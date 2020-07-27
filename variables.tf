# AWS provider credentials
variable "access_key" {}
variable "secret_key" {}
variable "public_key" {}

// default region
variable "region" {
  default = "eu-central-1"
}

# EC2 parameters
#
variable "ec2ami" {
  default = "ami-00aa4671cbf840d82"
}

variable "instance_type" {
  default = "t2.micro"
}

/*variable "" {
  default = ""
}
*/
