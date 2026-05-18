output "instance_public_ip" {
  description = "Public IP of EC2 instance"
  value       = aws_instance.ec2.public_ip
}

output "instance_id" {
  description = "EC2 instance ID"
  value       = aws_instance.ec2.id
}

output "subnet_ids" {
  value = data.aws_subnets.public_subnets.ids
}