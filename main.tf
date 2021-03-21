resource "aws_iam_role" "ssm_role" {
  #Creating the role for EC2 to allow access from SSM
  name               = "SSM-IAM-ROLE"
  assume_role_policy = <<EOF
{
 "Version": "2012-10-17",
 "Statement": [
   {
     "Action": "sts:AssumeRole",
     "Principal": {
       "Service": "ec2.amazonaws.com"
     },
     "Effect": "Allow",
     "Sid": ""
   }
 ]
}
EOF
}

resource "aws_iam_instance_profile" "ssm_profile" {
  # Creating a instance profile to connect SSM to EC2
  role = aws_iam_role.ssm_role.name
}

resource "aws_iam_policy" "policy" {
  #Allow SSM policy 
  name        = "ssm_ec2_policy"
  description = "ssm_ec2_policy"
  policy      = file("ssm_policy.json")
}

resource "aws_iam_policy_attachment" "ssm_role_policy_attach" {
  #attaching ssm policy to the ssm role
  name       = "ssm_role_policy_attachment"
  roles      = ["aws_iam_role.ssm_role.name"]
  policy_arn = "aws_iam_policy.policy.arn"
}

resource "aws_instance" "AlexsInstance" {
  #Creating the EC2 instance with the policy attached.
    ami = "ami-0dde09624ce7c64cc"
    instance_type = "t2.micro"
    iam_instance_profile = aws_iam_instance_profile.ssm_profile.name
    tags = {
      "Name" = "Terraform"
    }
  
}