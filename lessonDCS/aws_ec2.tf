# ------------------------------------------------
# EC2インスタンスの作成
# ------------------------------------------------

# 記入方法
# resource "リソースの種類" "リソース名" {
#   設定項目 = "値"
# }
resource "aws_instance" "sample_web_server" {
    ami                     = "ami-ami-013a28d7c2ea10269"           # Amazon Linux 2023 AMI
    instance_type           = "t2.micro"                            # インスタンスタイプ
    subnet_id               = aws_subnet.sample_subnet_id           # サブネットのID
    vpc_security_group_ids  = [ aws_security_group.sample_sg.id ]   # セキュリティグループのID

# Webサーバ（Apache）をインストールおよび起動させるためのユーザデータ
    user_data = <<EOF    
#! /bin/bash
sudo yum install -y httpd
sudo systemctl start httpd
sudo systemctl enable httpd
EOF

    tags = {
        Name = "sample_web_server"  # インスタンス名
    }
}