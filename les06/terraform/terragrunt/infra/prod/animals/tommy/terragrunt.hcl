terraform {
  source = "../../../../../animals/modules/animal"
}

dependency "subnet" {
  config_path = "../cats"

  mock_outputs = {
    subnet_id = "subnet-11100f"
  }
  mock_outputs_allowed_terraform_commands = ["init", "validate", "plan", "destroy"]

}

inputs = {
  subnet_id = dependency.subnet.outputs.subnet_id
  nickname = "tommy"
}

include "root" {
  path = find_in_parent_folders()
}
