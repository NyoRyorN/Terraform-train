# ------------------------------------------------
# EC2インスタンスの作成
# ------------------------------------------------

# 記入方法
# resource "リソースの種類" "リソース名" {
#   設定項目 = "値"
# }
resource "aws_instance" "sample_web_server" {
  ami                    = "ami-0eda63ec8af4f056e"           # Amazon Linux 2 AMI
  instance_type          = "t2.micro"                        # インスタンスタイプ
  subnet_id              = aws_subnet.sample_subnet.id       # サブネットのID
  vpc_security_group_ids = [aws_security_group.sample_sg.id] # セキュリティグループのID

  # Webサーバ（Apache）をインストールおよび起動させるためのユーザデータ
  user_data = <<EOF
#! /bin/bash
sudo yum install -y httpd
sudo systemctl start httpd
sudo systemctl enable httpd
EOF

}