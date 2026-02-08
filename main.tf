provider "aws" {
  region = "ap-south-1"
}

provider "vault" {
  address          = "http://3.108.54.77:8200"
  skip_child_token = true
  skip_tls_verify  = true

  auth_login {
    path = "auth/approle/login"

    parameters = {
      role_id   = "ea9dfa49-199a-91d9-74d6-be7231ae7850"
      secret_id = "2ba5f95f-6353-f7e6-a7b8-e315a4930b6d"
    }
  }
}

data "vault_kv_secret_v2" "test-vault" {
  mount = "kv"
  name  = "test-vault"
}

resource "aws_instance" "my_instance" {
  ami           = "ami-019715e0d74f695be"
  instance_type = "t2.micro"

  tags = {
    Name = "test"
  }
}
