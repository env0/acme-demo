provider "aws" {
  region = "eu-west-2"
}

#resource "aws_instance" "amazon_linux" {
#  ami           = "ami-0ed07aaf6fbeab6bc"
#  instance_type = "t3.micro"
#  key_name      = "awseu"
#  tags {
#    env = "dev"
#  }
#}

# t4g.nano = arm 512mb — use t4g.micro for 1gb
# $0.0005ph in London eu-west-2
# https://www.freebsd.org/releases/13.0R/announce/
resource "aws_instance" "freebsd" {
  ami           = "ami-0366c84035a278843"
  instance_type = "t4g.nano"
  key_name      = "key-lon"
}

output "instance_public_dns" {
  value = aws_instance.freebsd.public_dns
}
