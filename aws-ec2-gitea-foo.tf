provider "aws" {
    profile = "Terraform"
    region = "ap-southeast-1"
    access_key = "access_key"
    secret_key = "secret_key"
}

resource "aws_instance" "demo_instance" {
    ami = "ami-055d15d9cfddf7bd3"
    instance_type = "t2.micro"
	key_name = "key_name"
	subnet_id = "subnet-95399ec6"
	associate_public_ip_address = true
	vpc_security_group_ids = ["sg-054dsfg34gdsfg38"]
	user_data = <<-EOF
					#!/bin/bash
					sudo apt update -y
					sudo adduser \
					>    --system \
					>    --shell /bin/bash \
					>    --gecos 'Git Version Control' \
					>    --group \
					>    --disabled-password \
					>    --home /home/git \
					>    git
					snap install gitea
					sudo apt install mariadb-server -y
					chmod +x gitea-*-linux-amd64
					sudo mv gitea-*-linux-amd64 /usr/local/bin/gitea
					sudo mkdir -p /var/lib/gitea/{custom,data,log}
					sudo chown -R git:git /var/lib/gitea/
					sudo chmod -R 750 /var/lib/gitea/
					sudo mkdir /etc/gitea
					sudo chown root:git /etc/gitea
					sudo chmod 770 /etc/gitea
					sudo wget https://raw.githubusercontent.com/go-gitea/gitea/main/contrib/systemd/gitea.service -P /etc/systemd/system/
					sudo systemctl daemon-reload
					sudo systemctl enable --now gitea
				EOF
    tags = {
        Name = "Gitea Demo"
          }
}