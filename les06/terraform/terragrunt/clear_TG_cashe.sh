#find . -type d -name ".terragrunt-cache" -prune -exec rm -rf {}
rm -rf $(find . -type d -name ".terragrunt-cache")
