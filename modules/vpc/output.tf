output "vpc_id" {
    value = aws_vpc.myvpc.id
}
output "subnet" {
    value = aws_subnet.subnets[*].id
}
