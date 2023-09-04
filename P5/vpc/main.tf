resource "aws_vpc" "vpc1" {
  cidr_block       = "${var.vpc1_cidr}"
  instance_tenancy = "default"

  tags = {
    Name = "vpc1"
  }
}

resource "aws_subnet" "public-vpc1" {
  vpc_id     = "${var.vpc1_id}"
  cidr_block = "${var.vpc1_pub}"
  availability_zone = "us-east-1a"

  tags = {
    Name = "pub_vpc1"
  }
}

resource "aws_subnet" "private-vpc1" {
  vpc_id     = "${var.vpc1_id}"
  cidr_block = "${var.vpc1_pvt}"
  availability_zone = "us-east-1a"

  tags = {
    Name = "pvt_vpc1"
  }
}

resource "aws_internet_gateway" "VPC1IGW" {
  vpc_id = "${var.vpc1_id}"

  tags = {
    Name = "VPC1IGW"
  }
}

resource "aws_eip" "eip-for-nat-gateway-1" {
  vpc    = true

  tags   = {
    Name = "EIP1"
  }
}

resource "aws_nat_gateway" "NATGWVPC1" {
  allocation_id = aws_eip.eip-for-nat-gateway-1.id
  subnet_id     = aws_subnet.public-vpc1.id

  tags = {
    Name = "NATGWVPC1"
  }
}

resource "aws_route_table" "pub-RT" {
  vpc_id = "${var.vpc1_id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.VPC1IGW.id
  }
}

resource "aws_route_table" "pvt-RT" {
  vpc_id = "${var.vpc1_id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.NATGWVPC1.id
  }
}

resource "aws_route" "transit_gateway_route" {
  route_table_id            = aws_route_table.pub-RT.id
  destination_cidr_block    = "10.0.0.0/8"
  transit_gateway_id        = "${var.TGW_id}"
}

resource "aws_route_table_association" "pub-sub-rt" {
  subnet_id      = aws_subnet.public-vpc1.id
  route_table_id = aws_route_table.pub-RT.id
}

resource "aws_route_table_association" "pvt-sub-rt" {
  subnet_id      = aws_subnet.private-vpc1.id
  route_table_id = aws_route_table.pvt-RT.id  
}

############################################################################################################
#VPC1 OUTPUT

output "vpc1_id" {
  value = "${aws_vpc.vpc1.id}"
}

output "TGWATTsubnet" {
  value = "${aws_subnet.private-vpc1.id}"
}

output "subnet1vpc1" {
  value = "${aws_subnet.public-vpc1.id}"
}

############################################################################################################
#CREATING VPC2

resource "aws_vpc" "vpc2" {
  cidr_block       = "${var.vpc2_cidr}"
  instance_tenancy = "default"

  tags = {
    Name = "vpc2"
  }
}

resource "aws_subnet" "private1-vpc2" {
  vpc_id     = "${var.vpc2_id}"
  cidr_block = "${var.vpc2_pvt1}"
  availability_zone = "us-east-1a"

  tags = {
    Name = "pvt1_vpc2"
  }
}

resource "aws_subnet" "private2-vpc2" {
  vpc_id     = "${var.vpc2_id}"
  cidr_block = "${var.vpc2_pvt2}"
  availability_zone = "us-east-1a"

  tags = {
    Name = "pvt2_vpc2"
  }
}

#
#resource "aws_internet_gateway" "VPC1IGW" {
##  vpc_id = "${var.vpc1_id}"
##
##  tags = {
##    Name = "VPC1IGW"
##  }
##}
##
#resource "aws_eip" "eip-for-nat-gateway-1" {
#  vpc    = true
#
#  tags   = {
#    Name = "EIP1"
#  }
#}
#
#resource "aws_nat_gateway" "NATGWVPC1" {
#  allocation_id = aws_eip.eip-for-nat-gateway-1.id
#  subnet_id     = aws_subnet.public-vpc1.id
#
#  tags = {
#    Name = "NATGWVPC1"
#  }
#}
#
#resource "aws_route_table" "pub-RT" {
#  vpc_id = "${var.vpc1_id}"
#
#  route {
#    cidr_block = "0.0.0.0/0"
#    gateway_id = aws_internet_gateway.VPC1IGW.id
#  }
#}

resource "aws_route_table" "pvt-RT-vpc2" {
  vpc_id = "${var.vpc2_id}"

  route {
    cidr_block = "0.0.0.0/0"
    transit_gateway_id = "${var.TGW_id}"
  }
}
#
#resource "aws_route_table_association" "pub-sub-rt" {
#  subnet_id      = aws_subnet.public-vpc1.id
#  route_table_id = aws_route_table.pub-RT.id
#}

resource "aws_route_table_association" "pvt-sub-rt11" {
  subnet_id      = aws_subnet.private1-vpc2.id
  route_table_id = aws_route_table.pvt-RT-vpc2.id
}

resource "aws_route_table_association" "pvt-sub-rt22" {  
  subnet_id      = aws_subnet.private2-vpc2.id
  route_table_id = aws_route_table.pvt-RT-vpc2.id
}

######################################################
#OUTPUT
output "vpc2_id" {
  value = "${aws_vpc.vpc2.id}"
}

output "TGWATT2subnet" {
  value = "${aws_subnet.private1-vpc2.id}"
}

output "private2-vpc2" {
  value = "${aws_subnet.private2-vpc2.id}"
}
######################################################

