resource "aws_instance" "AlexsInstance" {
    
    ami = "ami-069302b967476d106"
    instance_type = "t2.micro"
    tags = {
      "Name" = "Terraform"
    }
  
}