module "elb_logs" {
  source = "honeycombio/integrations/aws//s3-logfile"

  name               = "tf-integrations-elb-${random_pet.this.id}"
  parser_type        = "elb"
  honeycomb_api_key  = var.honeycomb_api_key
  honeycomb_api_host = var.honeycomb_api_host
  # bucket containing elb logs
  s3_bucket_arn = module.elb_log_bucket.s3_bucket_arn
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

module "elb_log_bucket" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "~> 3.0"

  bucket        = "honeycomb-tf-integrations-elb-logs"
  force_destroy = true
}
