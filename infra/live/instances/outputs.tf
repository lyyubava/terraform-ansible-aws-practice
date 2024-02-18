output "db_ec2_private_ip" {
  value = module.db_instance.ec2_private_ip
}

output "traefik_ec2_public_ip" {
  value = module.traefik_instance.ec2_public_ip
}

output "wordpress_ec2_private_ip" {
  value = module.wordpress_instance.ec2_private_ip
}

