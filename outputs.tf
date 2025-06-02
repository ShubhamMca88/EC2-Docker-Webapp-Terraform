output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.webapp.id
}

output "instance_private_ip" {
  description = "Private IP address of the EC2 instance"
  value       = aws_instance.webapp.private_ip
}

output "alb_dns_name" {
  description = "DNS name of the Application Load Balancer"
  value       = aws_lb.webapp_alb.dns_name
}

output "webapp_url" {
  description = "URL to access the web application"
  value       = "http://${aws_lb.webapp_alb.dns_name}"
}