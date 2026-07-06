############################################################
# VPC Outputs
############################################################

output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.this.id
}

############################################################
# Public Subnets
############################################################

output "public_subnet_ids" {
  description = "Public Subnet IDs"

  value = [
    aws_subnet.public_1.id,
    aws_subnet.public_2.id
  ]
}

############################################################
# Private Subnets
############################################################

output "private_subnet_ids" {
  description = "Private Subnet IDs"

  value = [
    aws_subnet.private_1.id,
    aws_subnet.private_2.id
  ]
}

############################################################
# Internet Gateway
############################################################

output "internet_gateway_id" {
  description = "Internet Gateway ID"
  value       = aws_internet_gateway.this.id
}

############################################################
# NAT Gateway
############################################################

output "nat_gateway_id" {
  description = "NAT Gateway ID"
  value       = aws_nat_gateway.this.id
} ############################################################


 

 

