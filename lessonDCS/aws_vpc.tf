# 記入方法
# resource "リソースの種類" "リソース名" {
#   設定項目 = "値"
# }

# ------------------------------------------------
# VPCの作成
# ------------------------------------------------
resource "aws_vpc" "sample_vpc" {
    cidr_block            = "10.0.0.0/16" # VPCのCIDR
    enable_dns_hostnames  = true          # DNSホスト名を有効化
}

# ------------------------------------------------
# パブリックサブネットの作成
# ------------------------------------------------
resource "aws_subnet" "sample_subnet" {
    vpc_id                    = aws_vpc.sample_vpc.id # VPCのID
    cidr_block                = "10.0.1.0/24"         # サブネットのCIDR
    availability_zone         = "ap-northeast-1a"     # サブネットのAZ/東京リージョンのaゾーン
    map_public_ip_on_launch   = true                  # インスタンス起動時にパブリックIPを自動割り当て
}

# ------------------------------------------------
# インターネットゲートウェイの作成
# ------------------------------------------------
resource "aws_internet_gateway" "sample_igw" {
    vpc_id = aws_vpc.sample_vpc.id # VPCのID
}

# ------------------------------------------------
# ルートテーブルの作成
# ------------------------------------------------
resource "aws_route_table" "sample_rtb" {
    vpc_id = aws_vpc.sample_vpc.id # VPCのID

    route = {
        cidr_block = "0.0.0.0/0"                        # すべてのIPアドレスからのトラフィックを指定
        gateway_id = aws_internet_gateway.sample_igw.id # インターネットゲートウェイのID
    }
}

# ------------------------------------------------
# サブネットにルートテーブルを関連付け
# ------------------------------------------------
resource "aws_route_table_association" "sample_rt_assoc" {
    subnet_id       = aws_subnet.sample_subnet.id   # サブネットのID
    route_table_id  = aws_route_table.sample_rtb.id # ルートテーブルのID
}

# ------------------------------------------------
# セキュリティグループの作成
# ------------------------------------------------
resource "aws_security_group" "sample_sg" {
    name    = "sample_sg"           # セキュリティグループ名
    vpc_id  = aws_vpc.sample_vpc.id # VPCのID

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