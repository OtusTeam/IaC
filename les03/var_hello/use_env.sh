export TF_VAR_input_hello="Hello form env!"
terraform apply
unset TF_VAR_input_hello
