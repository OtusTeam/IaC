export TF_VAR_input_hello="Hello form env!"
terraform apply --auto-approve
unset TF_VAR_input_hello
