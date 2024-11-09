output "vpc_id" {
  description = "VPC ID"
  value       = module.vpc.vpc_id
}

output "public_subnet_ids" {
  description = "Public Subnet IDs"
  value       = module.vpc.public_subnets
}

output "private_subnet_ids" {
  description = "Private Subnet IDs"
  value       = module.vpc.private_subnets
}

output "igw_id" {
  description = "Internet Gateway ID"
  value       = module.vpc.igw_id
}

output "nat_gateway_ids" {
  description = "NAT Gateway IDs"
  value       = module.vpc.natgw_ids
}

output "nat_gateway_eip" {
  description = "NAT Gateway EIP"
  value       = module.vpc.nat_public_ips
}

output "public_route_table_ids" {
  description = "The IDs of the public route tables"
  value       = module.vpc.public_route_table_ids
}

output "private_route_table_ids" {
  description = "The IDs of the private route tables"
  value       = module.vpc.private_route_table_ids
}

output "s3_endpoint_id" {
  description = "S3 Endpoint ID"
  value       = aws_vpc_endpoint.s3.id
}