provider "aws" {
  region = "ap-northeast-1"
}

resource "aws_instance" "example" {
  ami           = "ami-0b9a26d37416470d2" # Amazon Linux 2 AMI in ap-northeast-1 
  instance_type = "t3a.micro"             # t3a.micro instance type
}
