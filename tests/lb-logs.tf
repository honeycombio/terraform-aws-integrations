module "alb_logs" {
  source = "../modules/lb-logs"

  name               = "tf-integrations-alb-${random_pet.this.id}"
  honeycomb_api_key  = var.honeycomb_api_key
  honeycomb_api_host = var.honeycomb_api_host

  s3_bucket_arn = data.aws_s3_bucket.log_bucket.arn
}

// ideally this would be dynamically created, but using a random_pet in the bucket name
// and the feeding it into the ALB module results in a TF provider error:
//   When expanding the plan for module.alb.aws_lb.this[0] to include new values
//   learned so far during apply, provider "registry.terraform.io/hashicorp/aws"
//   produced an invalid new value for .access_logs[0].bucket: was
//   cty.StringVal(""), but now
//   cty.StringVal("honeycomb-tf-integrations-logs-decent-sunbird").

data "aws_s3_bucket" "log_bucket" {
  bucket = "honeycomb-tf-integrations-logs"
}

module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "~> 7.0"

  name               = random_pet.this.id
  load_balancer_type = "application"

  vpc_id          = data.aws_vpc.default.id
  subnets         = toset(data.aws_subnets.default.ids)
  security_groups = [aws_security_group.allow_http.id]

  access_logs = {
    bucket = data.aws_s3_bucket.log_bucket.id
  }

  target_groups = [
    {
      name_prefix      = "defaul"
      backend_protocol = "HTTP"
      backend_port     = 80
      target_type      = "instance"
    }
  ]

  http_tcp_listeners = [{
    port     = 80
    protocol = "HTTP"
    http_listener_rules = [{
      actions = [{
        type         = "fixed-response"
        content_type = "text/plain"
        status_code  = 200
        message_body = "Hello"
      }]
    }]
  }]
}

resource "aws_security_group" "allow_http" {
  name        = "allow_http-${random_pet.this.id}"
  description = "Allow HTTP inbound traffic"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    description      = "HTTP from public"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

