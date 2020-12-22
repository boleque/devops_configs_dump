provider "aws" {
  region = "us-east-2"
}

resource "aws_instance" "builder" {
  ami           = "ami-0ebc8f6f580a04647"
  instance_type = "t2.micro"
  subnet_id     = "subnet-5fda0334"
  key_name      = "${var.key_pair_name}"

  vpc_security_group_ids = [
    aws_security_group.allow_all.id
]

  user_data = << EOF
#! /bin/bash
sudo apt-get update
sudo apt install -y default-jdk maven awscli
git clone https://github.com/boxfuse/boxfuse-sample-java-war-hello.git
cd boxfuse-sample-java-war-hello && mvn package
export AWS_ACCESS_KEY_ID="${var.aws_key_id}"
export AWS_SECRET_ACCESS_KEY="${var.aws_secret_key}"
aws s3 cp target/hello-1.0.war s3://basket.boleque.com
EOF

  tags = {
    Name = "builder
}

}

resource "aws_instance" "production" {
  ami           = "ami-0ebc8f6f580a04647"
  instance_type = "t2.micro"
  subnet_id     = "subnet-5fda0334"
  key_name      = var.key_pair_name

  vpc_security_group_ids = [
    aws_security_group.allow_all.id
]

  user_data = << EOF
#!/bin/bash
sudo apt update
sudo apt install -y tomcat8 awscli
export AWS_ACCESS_KEY_ID="${var.aws_key_id}"
export AWS_SECRET_ACCESS_KEY="${var.aws_key_id}"
aws s3 cp s3://basket.boleque.com /var/lib/tomcat/webapps/hello-1.0.war
EOF

  tags = {
    Name = "builder"
}

}

resource "aws_security_group" "allow_all" {
  name        = "allow_all_group"
  description = "allow all ips for connection"

ingress {
    description = "allow connection to tomcat service"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

ingress {
    description = "allow connection by ssh to aws instances"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

