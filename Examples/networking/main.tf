terraform {
  required_providers {
	aws = {
	  source  = "hashicorp/aws"
	  version = "5.99.1"
	}
  }
}
# provider block here in provider.tf

resource "aws_vpc" "my-vpc" {
  cidr_block = var.vpc_cidr
  enable_dns_hostnames = true
  tags = { Name = "${var.env}-vpc" }
}

resource "aws_subnet" "my-subnet" {
  vpc_id = aws_vpc.my-vpc.id
  cidr_block = var.subnet_cidr
  #map_customer_owned_ip_on_launch = false
  tags = { Name = "${var.env}-subnet" }
}

resource "aws_internet_gateway" "my-igw" {
  vpc_id = aws_vpc.my-vpc.id
  tags = { Name = "${var.env}-igw" }
}

resource "aws_route_table" "my-public-rt" {
  vpc_id = aws_vpc.my-vpc.id
  route {
	cidr_block = "0.0.0.0/0"
	gateway_id = aws_internet_gateway.my-igw.id
  }
  tags = { Name = "${var.env}-public-rt" }
}

resource "aws_route_table_association" "public-rta" {
  subnet_id      = aws_subnet.my-subnet.id
  route_table_id = aws_route_table.my-public-rt.id
}