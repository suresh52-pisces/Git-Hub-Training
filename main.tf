#Writing the program for creating an ec2 instance

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.99.1"
    }
  }
}

/*resource "aws_instance" "terraform-instance1" {
  count = 2
  ami 			= "ami-087d1c9a513324697"
  instance_type = "t2.micro"
}*/

variable "instance_details"{
  description = "Instance type details"
  type = string

}
data "aws_key_pair" "My-KeyPair" {
  key_name = "Aws-Cli-KP"
}