provider "aws" {
  region = "ap-south-1"
}

provider "vault" {
  # Updated with your active Vault IP from the browser screenshot
  address          = "http://3.108.54.77:8200" 
  skip_child_token = true
  skip_tls_verify  = true

  auth_login {
    path = "auth/approle/login"

    parameters = {
      role_id   = "ea9dfa49-199a-91d9-74d6-be7231ae7850"
      secret_id = "a01acb6f-8ea2-24df-cfe8-4fdd9daf7b74"
    }
  }
}

# Fixed: Changed from data "kv" to "vault_kv_secret_v2"
data "vault_kv_secret_v2" "test-vault" {
  mount = "kv"          # Matches the mount path in your screenshot
  name  = "test-vault"  # Matches the secret name in your screenshot
}

resource "aws_instance" "my_instance" {
  ami           = "ami-019715e0d74f695be"
  instance_type = "t2.micro"

  tags = {
    Name = "test"
    # Example of how to use the secret data in a tag
    # SecretKey = data.vault_kv_secret_v2.test-vault.data["your_key_here"]
  }
}
