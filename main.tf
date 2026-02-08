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
      role_id   = " 46873d61-e34d-748f-8479-7bfbbfd53fd6"
      secret_id = "f9ed59ce-efab-63c0-9328-68569826ed7a"
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
