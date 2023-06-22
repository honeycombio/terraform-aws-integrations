module "alb_logs" {
  source = "../modules/s3-logfile"

  name               = "tf-integrations-alb-${random_pet.this.id}"
  parser_type        = "alb"
  honeycomb_api_key  = var.honeycomb_api_key
  honeycomb_api_host = var.honeycomb_api_host

  s3_bucket_arn = data.aws_s3_bucket.log_bucket.arn

  sample_rate_rules = [{
    Prefix     = "sampled-2",
    SampleRate = 2
  }]
}

module "elb_logs" {
  source = "../modules/s3-logfile"

  parser_type        = "elb"
  name               = "tf-integrations-elb-${random_pet.this.id}"
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

/*** ALB ***/

module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "~> 7.0"

  name               = "${random_pet.this.id}-sampled-2"
  load_balancer_type = "application"

  vpc_id          = data.aws_vpc.default.id
  subnets         = toset(data.aws_subnets.default.ids)
  security_groups = [aws_security_group.allow_http.id]

  access_logs = {
    bucket = data.aws_s3_bucket.log_bucket.id
    prefix = "sampled-2"
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

/*** ELB ***/

module "elb" {
  source  = "terraform-aws-modules/elb/aws"
  version = "~> 3.0"

  name = random_pet.this.id

  subnets         = toset(data.aws_subnets.default.ids)
  security_groups = [aws_security_group.allow_http.id]
  internal        = false

  number_of_instances = 1
  instances           = module.ec2_instances.id

  health_check = {
    target              = "HTTP:80/"
    interval            = 30
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
  }

  access_logs = {
    bucket = data.aws_s3_bucket.log_bucket.id
  }

  listener = [
    {
      instance_port     = "80"
      instance_protocol = "http"
      lb_port           = "80"
      lb_protocol       = "http"
    },
  ]
}

data "aws_ami" "latest" {
  owners      = ["amazon"]
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-*-x86_64-ebs"]
  }
}

module "ec2_instances" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 2.0"

  instance_count = 1

  name                        = random_pet.this.id
  ami                         = data.aws_ami.latest.id
  instance_type               = "t2.micro"
  vpc_security_group_ids      = [aws_security_group.allow_http.id]
  subnet_id                   = element(data.aws_subnets.default.ids, 0)
  associate_public_ip_address = true
}
