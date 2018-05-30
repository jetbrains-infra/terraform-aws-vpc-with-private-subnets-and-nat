## About
Terraform module to bootstrap AWS VPC. 

Features:
* Private and public subnets
* Internet gateway
* NAT gateway 
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

```
module "project_vpc" {
  source   = "github.com/jetbrains-infra/terraform-aws-vpc-with-private-subnets-and-nat"
  project  = "myproject" // required
  multi_az = false
  rds      = false
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
* `nat_ip_1` 
* `nat_ip_2` (empty if MultiAZ mode disabled)
