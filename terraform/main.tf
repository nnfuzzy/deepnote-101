terraform {
  required_version = ">= 1.2.0, < 2.0.0"
}

provider "aws" {
  region = "eu-central-1"
}

# S3
resource "aws_s3_bucket" "example_bucket" {
  bucket = var.s3_bucket_name
}

# Restricted IAM
resource "aws_iam_user" "s3_user" {
  name = var.deepnote_s3_user
}

resource "aws_iam_access_key" "s3_user_key" {
  user = aws_iam_user.s3_user.name
}

resource "aws_iam_policy" "s3_policy" {
  name   = "s3_policy"
  policy = jsonencode({
    Version   = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:ListBucket"
        ]
        Resource = [
          "${aws_s3_bucket.example_bucket.arn}",
          "${aws_s3_bucket.example_bucket.arn}/*"
        ]
      }
    ]
  })
}

resource "aws_iam_user_policy_attachment" "s3_user_policy" {
  user       = aws_iam_user.s3_user.name
  policy_arn = aws_iam_policy.s3_policy.arn
}

# Password for DB

resource "random_pet" "db_username" {
  length    = 8
  separator = ""
}

resource "random_password" "db_password" {
  length           = 16
  special          = true
  override_special = "/@%_"
}

# Usage of your default vpc

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  create_vpc = false
  manage_default_vpc               = true
  default_vpc_name                 = "default"
  default_vpc_enable_dns_hostnames = true
}

# Port release
resource "aws_security_group" "rds_sg" {
  vpc_id = module.vpc.default_vpc_id
  name_prefix = "rds-sg"
  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_db_instance" "db" {
  identifier              = var.deepnote_db_name
  #username                = random_pet.db_username.id
  username                = "app"
  password                = random_password.db_password.result
  port                    = "5432"
  engine                  = "postgres"
  engine_version          = "14.6"
  instance_class          = "db.t3.micro"
  allocated_storage       = "10"
  storage_encrypted       = false
  vpc_security_group_ids  = [aws_security_group.rds_sg.id]
  multi_az                = false
  storage_type            = "gp2"
  publicly_accessible     = true
  backup_retention_period = 7
  skip_final_snapshot     = true
}

