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

resource "aws_dynamodb_table_item" "user_item" {
  table_name = aws_dynamodb_table.users.id
  hash_key   = "UserId"
  item       = jsonencode({
     UserId = "user123",
     UserName = "Luke Skywalker",
     Email = "usetheforceluke@example.com"
  })
}
