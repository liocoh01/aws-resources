output "development-vpc" {
  value = aws_vpc.development-vpc.id
}
output "subnet-public-1" {
  value = aws_subnet.public-subnet-1.id
}
output "subnet-public-2" {
  value = aws_subnet.public-subnet-2.id
}
output "subnet-private-1" {
  value = aws_subnet.private-subnet-1.id
}
output "subnet-private-2" {
  value = aws_subnet.private-subnet-2.id
}
output "zone_id" {
  value = aws_route53_zone.main.id
}
output "zone_name" {
  value = aws_route53_zone.main.name
}