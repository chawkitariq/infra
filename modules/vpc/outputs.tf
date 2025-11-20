output "subnet_ids" {
  description = "List of subnets IDs"
  value = {
    public_a : aws_subnet.public_a.id,
    public_b : aws_subnet.public_b.id,
    private_a1 : aws_subnet.private_a1.id,
    private_a2 : aws_subnet.private_a2.id,
    private_b1 : aws_subnet.private_b1.id,
    private_b2 : aws_subnet.private_b2.id
  }
}
