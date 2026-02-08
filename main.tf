provider "aws" {
  region = "ap-south-1"
}

provider "vault" {
  address          = "http://13.233.96.202:8200"
  skip_child_token = true
  skip_tls_verify = true


  auth_login {
    path = "auth/approle/login"

    parameters = {
      role_id   = "ea9dfa49-199a-91d9-74d6-be7231ae7850"
      secret_id = "a01acb6f-8ea2-24df-cfe8-4fdd9daf7b74"
    }
  }
}

data "vault_kv_secret_v2" "example" {
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
