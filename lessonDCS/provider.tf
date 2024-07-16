# 構築するリソースのプロバイダー情報を記載

provider "aws" {
  region = "ap-northeast-1"
}
# AWSのリソースを構築
# リージョンはap-northeast-1（東京リージョン）

# Azure の場合は provider "azurerm" { } と記載