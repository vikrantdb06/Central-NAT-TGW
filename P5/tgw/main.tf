resource "aws_ec2_transit_gateway" "TGW1" {
  description = "TGW1"
  default_route_table_association = "disable"
  default_route_table_propagation = "disable"
}

resource "aws_ec2_transit_gateway_vpc_attachment" "VPC1ATT" {
  subnet_ids         = "${[var.TGWATTsubnet]}" #[aws_subnet.example.id]
  transit_gateway_id = "${var.TGW_id}" # aws_ec2_transit_gateway.example.id
  vpc_id             = "${var.vpc1_id}" # aws_vpc.example.id
}

resource "aws_ec2_transit_gateway_route_table" "DEF-RT" {
  transit_gateway_id = "${var.TGW_id}"
}

resource "aws_ec2_transit_gateway_route" "default-route" {
  destination_cidr_block = "0.0.0.0/0"  # Destination CIDR block for the route
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.DEF-RT.id
  transit_gateway_attachment_id = "${var.VPC1ATT}" #aws_ec2_transit_gateway_vpc_attachment.VPC1ATT.id  # Replace with the appropriate attachment
}

# Associating vpc1 attachment:

resource "aws_ec2_transit_gateway_route_table_association" "VPC1CONN" {
  transit_gateway_attachment_id  =  "${var.VPC1ATT}"
  transit_gateway_route_table_id = "${var.aws-DEF-RT}"
}

#Propogating vpc1 attchment

resource "aws_ec2_transit_gateway_route_table_propagation" "VPC1PROPOGATE" {
  transit_gateway_attachment_id  =  "${var.VPC1ATT}"
  transit_gateway_route_table_id = "${var.aws-DEF-RT}"
}
#
#output "default-RT" {
#  value = "${aws_ec2_transit_gateway.TGW1.default_association_route_table}"
#}
#
output "TGW_id" {
  value = "${aws_ec2_transit_gateway.TGW1.id}"
}

output "VPC1ATT" {
    value = "${aws_ec2_transit_gateway_vpc_attachment.VPC1ATT.id}"
}

output "aws-DEF-RT" {
    value = "${aws_ec2_transit_gateway_route_table.DEF-RT.id}"
}

#module "aws_tgw_route_table-route" {
#  source                        = "git::https://github.com/khateeb15/terraform-aws-transitgateway-route-table-route"
#  destination_cidr              = "0.0.0.0/0"
#  tgw_route_table               = module.tgw.route_table_id
#  transit_gateway_attachment_id = module.tgw.attachment_id
#}

resource "aws_ec2_transit_gateway_vpc_attachment" "VPC2ATT" {
  subnet_ids         = "${[var.TGWATT2subnet]}" #[aws_subnet.example.id]
  transit_gateway_id = "${var.TGW_id}" # aws_ec2_transit_gateway.example.id
  vpc_id             = "${var.vpc2_id}" # aws_vpc.example.id
}

#resource "aws_ec2_transit_gateway_route_table" "DEF-RT" {
#  transit_gateway_id = "${var.TGW_id}"
#}

resource "aws_ec2_transit_gateway_route_table_association" "VPC2CONN" {
  transit_gateway_attachment_id  =  "${var.VPC2ATT}"
  transit_gateway_route_table_id = "${var.aws-DEF-RT}" #aws_ec2_transit_gateway_route_table.DEF-RT.id
}

#Propogating vpc1 attchment

resource "aws_ec2_transit_gateway_route_table_propagation" "VPC2PROPOGATE" {
  transit_gateway_attachment_id  =  "${var.VPC2ATT}"
  transit_gateway_route_table_id = "${var.aws-DEF-RT}"
}

output "VPC2ATT" {
    value = "${aws_ec2_transit_gateway_vpc_attachment.VPC2ATT.id}"
}
