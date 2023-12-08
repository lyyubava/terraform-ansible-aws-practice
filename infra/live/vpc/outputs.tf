output "vpc_private_subnet_arns" {
  value = module.vpc.private_subnet_arns
}

output "vpc_public_subnets_arns" {
  value = module.vpc.public_subnet_arns
}

output "vpc_public_subnets" {
  value = module.vpc.public_subnets
}

output "vpc_private_subnets" {
  value = module.vpc.private_subnets
}

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "vpc_cidr" {
  value = module.vpc.vpc_cidr_block
}
