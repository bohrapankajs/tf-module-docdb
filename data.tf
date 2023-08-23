data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = "mysecond-bucket-01"
    key    = "vpc/${var.ENV}/terraform.tfstate"
    region = "us-east-1"
  }
}


# Fecthing the information of the existing secret which has multiple values
data "aws_secretsmanager_secret" "robot-secrets" {
  name = "robot/secrets"
}

# Fecthing the ID of the secret version of the above secret
data "aws_secretsmanager_secret_version" "robot-secrets" {
  secret_id = data.aws_secretsmanager_secret.robot-secrets.id
}

# Fetching the secret value of the above secret
output "data" {
  value = jsondecode(data.aws_secretsmanager_secret_version.robot-secrets.secret_string)["DOCDB_USERNAME"]
}