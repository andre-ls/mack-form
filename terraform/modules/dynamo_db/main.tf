resource "aws_dynamodb_table" "users" {
  name = "UsersTable"
  billing_mode = "PROVISIONED"
  read_capacity = 10
  write_capacity = 5

  hash_key = "UserId"
  attribute {
    name = "UserId"
    type = "S"  # String data type
  }
}
