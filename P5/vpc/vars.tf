variable "vpc1_cidr" {
    default = "10.0.0.0/16"
}

variable "vpc1_pub" {
  default = "10.0.1.0/24"
}

variable "vpc1_id" {}

variable "vpc1_pvt" {
    default = "10.0.2.0/24"
}

#==============================

variable "vpc2_cidr" {
    default = "10.2.0.0/16"
}

variable "vpc2_pvt1" {
    default = "10.2.1.0/24"
}

variable "vpc2_pvt2" {
    default = "10.2.2.0/24"
}

variable "TGW_id" {}

variable "vpc2_id" {}