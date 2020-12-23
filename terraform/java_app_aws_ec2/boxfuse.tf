provider "aws" {
  region = "us-east-2"
}

resource "aws_instance" "builder" {
  ami = "ami-0a91cd140a1fc148a"
  instance_type = "t2.micro"
  key_name      = "bf2"
  vpc_security_group_ids = [aws_security_group.custom_group.id]
  
  tags = {
    Name = "builder"
}

  user_data = <<-EOF
              #!/bin/bash
              sudo apt-get update
              sudo apt install default-jdk maven awscli -y
              git clone https://github.com/boxfuse/boxfuse-sample-java-war-hello
              export AWS_ACCESS_KEY_ID="${var.aws_key_id}"
              export AWS_SECRET_ACCESS_KEY="${var.aws_secret_key}"
              cd boxfuse-sample-java-war-hello && mvn package
              aws s3 cp target/hello-1.0.war s3://backet.boleque.com
              EOF
}

resource "aws_instance" "production" {
  ami = "ami-0a91cd140a1fc148a"
  instance_type = "t2.micro"
  key_name      = "bf2"
  vpc_security_group_ids = [aws_security_group.custom_group.id]

  tags = {
    Name = "production"
}

  user_data = <<-EOF
              #!/bin/bash
              sudo apt-get update
              sudo apt install default-jre tomcat9 awscli -y
              export AWS_ACCESS_KEY_ID="${var.aws_key_id}"
              export AWS_SECRET_ACCESS_KEY="${var.aws_secret_key}"
              s3://backet.boleque.com/hello-1.0.war to tmp/hello-1.0.war
              sudo mv /tmp/hello-1.0.war /var/lib/tomcat9/webapps/hello-1.0.war
              EOF
}

resource "aws_security_group" "custom_group" {
  name = "custom_group"

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = 8080
        to_port = 8080
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}
