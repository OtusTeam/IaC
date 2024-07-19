run "check_hello_output" {
  command = plan

  assert {
    condition = output.hello_world == "Hello, World!"
    error_message = "Wrong output"
  }
}
