resource "aws_instance" "instance" {
  ami             = var.ami
  instance_type   = "t2.medium"
  key_name        = var.key_name
  vpc_security_group_ids = [var.security_group_id]
  subnet_id          = var.subnet
  associate_public_ip_address = true
  tags = {
    Name = var.name
  }
}


resource "aws_route53_record" "www" {
  zone_id = var.zone_id
  name    =  "${var.name}.${var.zone_name}"
  type    = "A"
  ttl     = "300"
  records = [aws_instance.instance.public_ip]
}


