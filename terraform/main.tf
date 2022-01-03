provider "aws" {
  region = var.region
}

module "network-1" {
  source = "./modules/network/"
  region = var.region
  environment = "development"
  vpc_cidr = "10.0.0.0/16"
  public_subnet_1_cidr  = "10.0.1.0/24"
  public_subnet_2_cidr  = "10.0.2.0/24"
  private_subnet_1_cidr = "10.0.10.0/24"
  private_subnet_2_cidr = "10.0.11.0/24"
}
module "sg-web" {
  source = "./modules/security_groups/web-servers"
  vpc = module.network-1.development-vpc
}

module "elb-1" {
  source = "./modules/elb"
  name   = "test-lb-tf"
  internal = false
  listener = [{
    instance_port: "8080", 
    instance_protocol: "HTTP", 
    lb_port: "80" , 
    lb_protocol: "HTTP"
    },
    {
    instance_port: "443", 
    instance_protocol: "HTTP", 
    lb_port: "443" , 
    lb_protocol: "HTTP"
    }
  ]
  security_groups    = [module.sg-web.id]
  subnets            = [module.network-1.subnet-public-1, module.network-1.subnet-public-2]
  health_check = {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:8080/"
    interval            = 30
  }
}

# Added Alias instead of CNAME to ELB
resource "aws_route53_record" "www" {
  zone_id = module.network-1.zone_id
  name    = "elb1.liorco300.site"
  type    = "A"

  alias {
    name                   = module.elb-1.elb_dns_name
    zone_id                = module.elb-1.elb_zone_id
    evaluate_target_health = true
  }
}