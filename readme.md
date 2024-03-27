# terraformのインストールと初期構築
Windowsにterraformをインストールして、デプロイするまで

### Windowsへのインストール

https://developer.hashicorp.com/terraform/install
からwindows amd64をインストールして、zipを解凍後に環境変数でパスを通すこと

### Terraformプロジェクトの環境構築

.tfファイルを作成して下記の内容を記載するのが一番早い。
```tf
provider "aws" {
  access_key = "<xxxx>"
  secret_key = "<xxxx>"
  region = "ap-northeast-1"
}

resource "aws_instance" "example" {
        ami = "ami-0701e21c502689c31"
        instance_type = "t2.micro"
}
```

ただし、access_key,secret_keyを直書きしている状態なので、後続の構成のようにcredentialsを読み込む設定にすること。

#### デプロイ用ファイルの作成(理想形)
**TODO:実行できなかったので、あとでドキュメントに目を通してこの構成にすること**
下記3ファイルを作成する。

1. デプロイ対象ファイルの作成
```
// deploy.tf
resource "aws_s3_bucket" "this" {
  bucket = "terraform-sample-bucket-pisakun"

  tags = {
    Name = "terraform-sample"
  }
}

```

2. provider.tfの作成
デプロイ先の取得上を記載する。
```tf
// provider.tf
variable "aws_shared_credentials_file" {
  type = string
}
variable "aws_profile" {
  type = string
}
variable "aws_region" {
  type = string
}

provider "aws" {
  shared_credentials_file = var.aws_shared_credentials_file
  profile                 = var.aws_profile
  region                  = var.aws_region
}
```


3. 2の取得先になる変数ファイルを作成する
```
// terraform.tfvars
aws_shared_credentials_file = "~/.aws/credentials"
aws_profile  = "terraform"
aws_region  = "ap-northeast-1"

```

#### デプロイ
ワークスペースを初期化する
> terraform init

applyが正しくできるか確認

> terraform plan

> terraform apply

バケットが作成されたかはCLIコマンドで確認

> aws s3 ls

最後に削除すること

> terraform destroy -auto-approve

### 参考

https://blog.serverworks.co.jp/2021/10/25/164530

インストールまで参考、terraformコマンドを実行するためには環境変数にパスを通す必要あり

https://qiita.com/hiyanger/items/ca337f70ad4801072850

ファイル構成など参考