run "condition_expected_wrong_instances_number" {
  command = plan

  module {
    source = "./tests/condition_expected_failure"
  }

  variables {
    const_num_webservers = 4
  }

  expect_failures = [
    var.const_num_webservers
  ]
}


run "check_expected_wrong_instances_number" {
  command = plan

  module {
    source = "./tests/check_expected_failure"
  }

  variables {
    const_num_webservers = 5
  }

  expect_failures = [
    check.wrong_const_num_webservers
  ]
}

