## About
Terraform module to bootstrap AWS VPC. 

Features:
* Private and public subnets
* Internet gateway
* NAT gateway (default: `true`)
* NAT instance (default: `false`. Read [more](https://docs.aws.amazon.com/AmazonVPC/latest/UserGuide/vpc-nat-comparison.html).)
* MultiAZ mode for high availability (default: `false`) 
* RDS subnets (default: `false`)

Networks:
- `10.0.0.0/28` - nat #1
- `10.0.0.16/28` - nat #2
- `10.0.0.32/27` - RDS
- `10.0.0.64/27` - RDS
- `10.0.1.0/24` - app #1
- `10.0.2.0/24` - app #2

## Usage

Minimal setup: VPC, NAT gw, w/o rds subnets, w/o multiAZ support 
```
module "project_vpc" {
  source            = "github.com/jetbrains-infra/terraform-aws-vpc-with-private-subnets-and-nat"
  project           = "myproject" // required
}
```

All options with default values:
```
module "project_vpc" {
  source            = "github.com/jetbrains-infra/terraform-aws-vpc-with-private-subnets-and-nat"
  project           = "myproject" // required
  multi_az          = false
  rds               = false
  nat_mode          = "gateway" // or "instance"
  nat_instance_type = "t2.small"
}
```

## Outputs

* `vpc_id` 
* `subnet_public_1`
* `subnet_public_2` (empty if MultiAZ mode disabled)
* `subnet_private_1`
* `subnet_private_2` (empty if MultiAZ mode disabled)
* `subnet_rds_1` (empty if RDS support disabled)
* `subnet_rds_2` (empty if RDS support disabled)
* `db_subnet_group` (empty if RDS support disabled)
* `nat_gw_ip_1` 
* `nat_gw_ip_2` (empty if MultiAZ mode disabled)
* `nat_instance_ip_1` 
* `nat_instance_ip_2` (empty if MultiAZ mode disabled)
* `default_security_group` 
