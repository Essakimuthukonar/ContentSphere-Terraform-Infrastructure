output "vpc_id" {
  description = "ID of the ContentSphere VPC"
  value       = module.vpc.vpc_id
}

output "subnet_id" {
  description = "ID of the ContentSphere subnet"
  value       = module.vpc.subnet_id
}

output "security_group_id" {
  description = "ID of the ContentSphere security group"
  value       = module.security_group.security_group_id
}

output "ec2_instance_id" {
  description = "ID of the ContentSphere EC2 instance"
  value       = module.ec2.instance_id
}

output "public_ip" {
  description = "Public IP address of the ContentSphere EC2"
  value       = module.ec2.public_ip
}

output "s3_bucket_name" {
  description = "Name of the ContentSphere S3 bucket"
  value       = module.s3.bucket_name
}
output "elastic_ip" {
  description = "Elastic IP address of the ContentSphere EC2"
  value       = module.ec2.elastic_ip
}