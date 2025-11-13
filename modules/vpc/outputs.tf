output "private_subnet_ids" {
  description = "List of subnet IDs for the 4 private subnets (in order)"
  value = {
    private_a1 : aws_subnet.private_a1.id,
    private_a2 : aws_subnet.private_a2.id,
    private_b1 : aws_subnet.private_b1.id,
    private_b2 : aws_subnet.private_b2.id
  }
}
