terraform {
  required_providers {
    aws ={
        source = "hashicorp/aws"
        version = "6.0"
    }
  }
  # Storing state file in remote location
  backend "s3" {
    
  }
}


provider "aws" {

}