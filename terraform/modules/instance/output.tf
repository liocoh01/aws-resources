output "instance_ip_address" {
  value = aws_instance.instance.public_ip
}
output "instance_fqdn" {
  value = aws_route53_record.www.fqdn
}