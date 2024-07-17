run "create_website" {
  command = apply

#  variables {
#    bucket_name = "${run.setup_tests.bucket_prefix}-aws-s3-website-test"
#  }

  # Check that the bucket name is correct
#  assert {
#    condition     = aws_s3_bucket.s3_bucket.bucket == "${run.setup_tests.bucket_prefix}-aws-s3-website-test"
#    error_message = "Invalid bucket name"
#  }

   assert {
     condition   = length(yandex_lb_network_load_balancer.les04_ylb.listener.*.external_address_spec[0].*.address[0]) > 0
     error_message = "Empty load balancer external ip address"
   }

  # Check index.html hash matches
#  assert {
#    condition     = aws_s3_object.index.etag == filemd5("./www/index.html")
#    error_message = "Invalid eTag for index.html"
#  }

  # Check error.html hash matches
#  assert {
#    condition     = aws_s3_object.error.etag == filemd5("./www/error.html")
#    error_message = "Invalid eTag for error.html"
#  }
}


/*
resource "test_assertions" "web_instances" {
  component = module.web

  checks = [
    {
      description = "Check if the load balancer external ip is not empty"
      condition   = length(module.web.yandex_lb_network_load_balancer.les04_ylb.listener.*.external_address_spec[0].*.address[0]) > 0
    },
    {
      description = "Check if there are 3 web instances"
      condition   = length(module.web.yandex_lb_target_group.les04_web_servers.target) == 3
    }
  ]
}
*/
