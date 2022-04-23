resource "random_password" "default" {
  length           = 16
  special          = true
  override_special = "_!%^"
}

resource "aws_secretsmanager_secret" "password" {
  name                    = "db-password-${random_id.default.id}"
  recovery_window_in_days = 0
  depends_on = [
    random_id.default
  ]
}

resource "aws_secretsmanager_secret_version" "password" {
  secret_id     = aws_secretsmanager_secret.password.id
  secret_string = random_password.default.result
}

resource "random_id" "default" {
  byte_length = 8
}