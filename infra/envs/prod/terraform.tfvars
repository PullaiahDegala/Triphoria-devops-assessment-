environment = "prod"

aws_region = "ap-south-1"

vpc_cidr = "10.1.0.0/16"

public_subnet_cidrs = [
  "10.1.1.0/24",
  "10.1.2.0/24"
]

private_subnet_cidrs = [
  "10.1.11.0/24",
  "10.1.12.0/24"
]

availability_zones = [
  "ap-south-1a",
  "ap-south-1b"
]

db_instance_class = "db.t3.small"

backup_retention_period = 7

deletion_protection = false