variable "project" {
  default = "Rohith"
}

variable "Environment" {
  type = map 
  default = {
  dev = "dev"
  prod = "prod"
  }
}

# variable "common_tags" {
#   default = "${project}-${environment}"
# }

variable "ec2_tags" {
  type = map
  default = {
    Terraform = "true"
    Project = "Rohith"
  }
}

variable "image" {
  type = string
  default = "ami-09c813fb71547fc4f"
}

variable "instance" {
  type = map 
  default = {
  dev = "t3.medium"
  prod = "t3.small"
  }
}

variable "instance_name" {
  default = ["mongodb" ]
  # default = {
  #   mongodb = "t3.micro"
  #   mysql = "t3.micro"
  #   redis = "t3.medium"
  # }
}

variable "domain_name" {
  type = string
  default = "rdaws86.fun"
}

variable "zone" {
  default = "Z08295323BHRO8KXCM7P0"
}

variable "ingress_ports" {
  default = ["22","8080","3306"]
  
}