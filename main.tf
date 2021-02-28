
provider "aws" {
  profile = "default"
  region  = "us-east-1"
}

 # 1. Create vpc

 #resource "aws_vpc" "tfprod-vpc" {
 #  cidr_block = "10.0.0.0/16"
 #  tags = {
 #    Name = "tfprod"
 #  }
 #}




