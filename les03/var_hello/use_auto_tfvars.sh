echo 'input_hello="Hello form auto tfvars!"' > input_hello.auto.tfvars
terraform apply --auto-approve
rm input_hello.auto.tfvars

