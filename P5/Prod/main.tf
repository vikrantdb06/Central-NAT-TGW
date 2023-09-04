provider "aws" {
  region     = "us-east-1"
  access_key = "AKIAQYTNWD7KOLOGHT7P"
  secret_key = "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"
}


module "vpc1" {
  source = "../vpc/"
  vpc1_id = "${module.vpc1.vpc1_id}"
  vpc2_id = "${module.vpc1.vpc2_id}"
  TGW_id = "${module.tgw.TGW_id}"
}

module "tgw" {
    source = "../tgw/"
    TGW_id = "${module.tgw.TGW_id}"
    TGWATTsubnet = "${module.vpc1.TGWATTsubnet}"
    vpc1_id = "${module.vpc1.vpc1_id}"
    VPC1ATT = "${module.tgw.VPC1ATT}"
    VPC2ATT = "${module.tgw.VPC2ATT}"
    vpc2_id = "${module.vpc1.vpc2_id}"
    TGWATT2subnet = "${module.vpc1.TGWATT2subnet}"
    aws-DEF-RT = "${module.tgw.aws-DEF-RT}"

}

module "ec2" {
  source = "../ec2/"
  ami = "ami-051f7e7f6c2f40dc1"
  vpc1_id = "${module.vpc1.vpc1_id}"
  vpc2_id = "${module.vpc1.vpc2_id}"
  subnet1vpc1 = "${module.vpc1.subnet1vpc1}"
  private2-vpc2 = "${module.vpc1.private2-vpc2}"

}




