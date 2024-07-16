terraform {
  source = "../../../../../animals/modules/subnet"
}

dependency "network" {
  config_path = "../network"

  mock_outputs = {
    network_id    = "vpc-444111"
  }
  mock_outputs_allowed_terraform_commands = ["init", "validate", "plan", "destroy"]
}

inputs = {
  network_id = dependency.network.outputs.network_id
  kind = "dogs"
  subnet_index = "2"
}

include "root" {
  path = find_in_parent_folders()
}
