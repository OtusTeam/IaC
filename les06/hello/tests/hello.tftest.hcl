run "check_hello_output" {

  assert {
    condition = output.hello_world == "Hello, World!"
    error_message = "Wrong output"
  }
}
