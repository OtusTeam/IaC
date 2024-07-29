#
# clear terraform:
rm -rf $(find . -type f -name "terraform.tfstate")
rm -rf $(find . -type f -name "terraform.tfstate.backup")
rm -rf $(find . -type d -name ".terraform")
rm -rf $(find . -type f -name ".terraform.lock.hcl")
# clear terragrunt:
rm -rf $(find . -type d -name ".terragrunt-cache")
