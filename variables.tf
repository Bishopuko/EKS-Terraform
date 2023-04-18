variable "aws_region" {
    default = "us-east-2"
}

variable "cidr_block"{
    default = "10.20.0.0/16"
}

variable "subnet_cidr_bits" {
  default     = 8
}

variable "az_count" {
    default = "2"
}
variable "netnum" {
    default = "15"
}
variable "netnumii" {
    default = "10"
  
}
variable "pub-avail" {
    default = "us-east-2a"  
}
variable "pri-avail" {
    default = "us-east-2b"
  
}
variable "name" {
    default = "EKS"
}
variable "node-group" {
    default = "EKS-NodeGP"
  
}