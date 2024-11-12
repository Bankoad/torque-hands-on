# Providerを設定
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = ">3.0.0"
    }
  }
}

provider "aws" {
  region = var.region
}

# セキュリティグループ
resource "aws_security_group" "wordpress_security_group" {
  name_prefix = "${var.name}-sg"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# インスタンス作成
resource "aws_instance" "wordpress_instance" {
  ami           = "ami-06a46da680048c8ae"
  instance_type = "t2.micro"
  subnet_id     = var.subnet_id
  key_name      = "testadoc"
  user_data     = <<-EOF
                  #!/bin/bash
                  yum install -y httpd wget
                  yum -y install epel-release
                  yum -y install http://rpms.famillecollet.com/enterprise/remi-release-7.rpm
                  yum -y install --disablerepo=* --enablerepo=epel,remi,remi-safe,remi-php74 php php-mysqlnd
                  setsebool -P httpd_can_network_connect 1
                  systemctl enable httpd
                  systemctl start httpd
                  cd /var/www/html
                  wget https://wordpress.org/latest.tar.gz
                  tar -xzvf latest.tar.gz --strip-components=1
                  cp wp-config-sample.php wp-config.php
                  sed -i 's/database_name_here/${var.db_name}/g' wp-config.php
                  sed -i 's/username_here/${var.db_username}/g' wp-config.php
                  sed -i 's/password_here/${var.db_password}/g' wp-config.php
                  sed -i 's/localhost/${var.db_endpoint}/g' wp-config.php
                  EOF

  # インスタンスに割り当てるセキュリティグループIDを指定
  vpc_security_group_ids = [aws_security_group.wordpress_security_group.id]

  tags = {
    Name = "${var.name}"
  }
}
