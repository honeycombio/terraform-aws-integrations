module "alb_logs" {
  source = "honeycombio/integrations/aws//s3-logfile"

  name               = "tf-integrations-alb-${random_pet.this.id}"
  parser_type        = "alb"
  honeycomb_api_key  = var.honeycomb_api_key
  honeycomb_api_host = var.honeycomb_api_host
  # bucket with alb access logs
  s3_bucket_arn = module.alb_log_bucket.s3_bucket_arn
}

# dependencies

data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
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

module "alb_log_bucket" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "~> 3.0"

  bucket        = "honeycomb-tf-integrations-alb-logs"
  force_destroy = true
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
