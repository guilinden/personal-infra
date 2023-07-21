data "aws_availability_zones" "available_zones" {
  state = "available"
  filter {
    name   = "region-name"
    values = [var.region]
  }
}