variable "region" {
  type = string
  default = "ap-south-2"
}
variable "vpc_cidr" {
  type = string
  default = "10.0.0.0/16"
}
variable "subnet_cidr" {
  type = string
  default = "10.0.1.0/24"
}
variable "env" {
  type = string
  default = "dev"
}