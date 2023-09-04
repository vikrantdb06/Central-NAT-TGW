
resource "aws_instance" "VPC1-EC2" {
  ami           = "${var.ami}"
  instance_type = "t2.micro"
#  vpc_id        = "${var.vpc1_id}"
  availability_zone = "us-east-1a"
  subnet_id = "${var.subnet1vpc1}"
  key_name = "key12"
  associate_public_ip_address = true

  tags = {
    Name = "VPC1-EC2"
  }
}

resource "aws_instance" "VPC2-EC2" {
  ami           = "${var.ami}"
  instance_type = "t2.micro"
#  vpc_id        = "${var.vpc2_id}"
  availability_zone = "us-east-1a"
  subnet_id = "${var.private2-vpc2}"
  key_name = "key12"
  

  tags = {
    Name = "VPC2-EC2"
  }
}


