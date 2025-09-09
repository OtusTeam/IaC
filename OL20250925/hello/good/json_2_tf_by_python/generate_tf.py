#!/usr/bin/env python3
import sys
import json
from typing import Any, Dict, List, Optional

def q(s: Any) -> str:
    """Возвращает HCL-строку для простых значений (строки/числа/булевы)."""
    if s is None:
        return "null"
    if isinstance(s, bool):
        return "true" if s else "false"
    if isinstance(s, (int, float)):
        return str(s)
    # экранировать двойные кавычки и слэши
    return '"' + str(s).replace('\\', '\\\\').replace('"', '\\"') + '"'

def indent(text: str, level: int = 1) -> str:
    pad = "  " * level
    return "\n".join(pad + line if line else "" for line in text.splitlines())

def render_block(name: str, body: str, level: int = 0) -> str:
    header = f"{name} {{"
    footer = "}"
    return ("\n" * (1 if level==0 else 0)) + indent(header, level).lstrip() + "\n" + indent(body, level+1) + "\n" + indent(footer, level)

def render_map(m: Dict[str, Any], skip_empty: bool = True, level: int = 0) -> str:
    lines: List[str] = []
    for k, v in m.items():
        if skip_empty and (v is None or v == {} or v == []):
            continue
        if isinstance(v, dict):
            body = render_map(v, skip_empty=skip_empty, level=level+1)
            lines.append(f'{k} = {body}')
        elif isinstance(v, list):
            # простая сериализация списков
            inner = ", ".join(q(x) for x in v)
            lines.append(f'{k} = [{inner}]')
        else:
            lines.append(f'{k} = {q(v)}')
    return "{\n" + indent("\n".join(lines), level+1) + "\n" + "  " * level + "}"

def gen_tf(data: Dict[str, Any]) -> str:
    # Пример: yandex_compute_instance resource (подставьте нужный провайдер/ресурс)
    name = data.get("name", "instance")
    res_name = name.replace(".", "_").replace("-", "_")
    lines: List[str] = []

    # resource header
    lines.append(f'resource "yandex_compute_instance" "{res_name}" ' + "{")

    # basic fields
    if "folder_id" in data:
        lines.append(f'  folder_id = {q(data["folder_id"])}')
    if "name" in data:
        lines.append(f'  name = {q(data["name"])}')
    if "zone_id" in data:
        lines.append(f'  zone = {q(data["zone_id"])}')
    if "platform_id" in data:
        lines.append(f'  platform_id = {q(data["platform_id"])}')

    # resources block
    resources = data.get("resources", {})
    if resources:
        res_lines = []
        if "cores" in resources:
            res_lines.append(f'cores = {q(resources["cores"])}')
        if "memory" in resources:
            res_lines.append(f'memory = {q(resources["memory"])}')
        if "core_fraction" in resources:
            res_lines.append(f'core_fraction = {q(resources["core_fraction"])}')
        if res_lines:
            lines.append("  resources {")
            lines.extend("    " + l for l in res_lines)
            lines.append("  }")

    # boot_disk
    boot = data.get("boot_disk", {})
    if boot:
        lines.append("  boot_disk {")
        if "mode" in boot:
            lines.append(f'    mode = {q(boot["mode"])}')
        if "device_name" in boot:
            lines.append(f'    device_name = {q(boot["device_name"])}')
        if "auto_delete" in boot:
            lines.append(f'    auto_delete = {q(boot["auto_delete"])}')
        if "disk_id" in boot:
            lines.append(f'    disk_id = {q(boot["disk_id"])}')
        lines.append("  }")

    # network_interfaces (array)
    nis = data.get("network_interfaces", [])
    for ni in nis:
        lines.append("  network_interface {")
        if "index" in ni:
            lines.append(f'    index = {q(ni["index"])}')
        if "mac_address" in ni:
            lines.append(f'    mac_address = {q(ni["mac_address"])}')
        if "subnet_id" in ni:
            lines.append(f'    subnet_id = {q(ni["subnet_id"])}')
        p4 = ni.get("primary_v4_address")
        if p4:
            lines.append("    primary_v4_address {")
            if "address" in p4:
                lines.append(f'      address = {q(p4["address"])}')
            one_to_one = p4.get("one_to_one_nat")
            if one_to_one:
                lines.append("      one_to_one_nat {")
                if "address" in one_to_one:
                    lines.append(f'        address = {q(one_to_one["address"])}')
                if "ip_version" in one_to_one:
                    lines.append(f'        ip_version = {q(one_to_one["ip_version"])}')
                lines.append("      }")
            lines.append("    }")
        lines.append("  }")

    # metadata_options -> metadata (example mapping)
    meta = data.get("metadata_options", {})
    if meta:
        # map known options into metadata map
        md_map = {}
        for k, v in meta.items():
            md_map[k] = v
        if md_map:
            # render as metadata = { ... }
            lines.append("  metadata = " + render_map(md_map, skip_empty=True, level=1))

    # scheduling_policy.preemptible -> scheduling { preemptible = true }
    sched = data.get("scheduling_policy", {})
    if sched:
        sp = sched.get("preemptible")
        if sp is not None:
            lines.append("  scheduling_policy {")
            lines.append(f'    preemptible = {q(sp)}')
            lines.append("  }")

    # ssh/serial settings as metadata or serial_port_settings block
    sps = data.get("serial_port_settings", {})
    if sps:
        if "ssh_authorization" in sps:
            lines.append(f'  serial_port_settings {{ ssh_authorization = {q(sps["ssh_authorization"])} }}')

    # gpu_settings (if present and non-empty) - naive mapping
    gpus = data.get("gpu_settings", {})
    if gpus:
        for k, v in gpus.items():
            lines.append(f'  # gpu_settings.{k} = {q(v)}')

    # hardware_generation.legacy_features.pci_topology
    hg = data.get("hardware_generation", {}).get("legacy_features", {}).get("pci_topology")
    if hg:
        lines.append(f'  # hardware_generation.legacy_features.pci_topology = {q(hg)}')

    # tags / labels example
    if "fqdn" in data:
        lines.append(f'  hostname = {q(data["fqdn"])}')

    # close resource
    lines.append("}")

    return "\n".join(lines)

def main():
    if len(sys.argv) < 2:
        print("Usage: generate_tf.py input.json", file=sys.stderr)
        sys.exit(2)
    path = sys.argv[1]
    with open(path, "r", encoding="utf-8") as f:
        data = json.load(f)
    tf = gen_tf(data)
    print(tf)

if __name__ == "__main__":
    main()
