terraform {
  source = "../../../../../animals/modules/network"
}

include "root" {
  path = find_in_parent_folders()
}
