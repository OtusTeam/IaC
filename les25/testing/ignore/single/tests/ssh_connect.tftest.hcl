run "check_ip" {

  assert {
    condition = length(output.vm_public_ip) > 0
    error_message = "VM ip address is empty"
  }
}

run "check_ssh_connect" {

  module {
    source = "./tests/ssh_connect"
  }

  variables {
    ip = run.check_ip.vm_public_ip   
  }
}


  
  


