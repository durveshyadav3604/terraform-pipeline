output "fetched_info_from_webapp1" {
  value = format("%s%s","ssh -i mykey ec2-user@",aws_instance.webapp1.public_ip)
}

output "fetched_info_from_webapp2" {
  value = format("%s%s","ssh -i mykey ec2-user@",aws_instance.webapp2.public_ip)
}

output "alb_dns_name" {
  value = aws_lb.alb.dns_name
}