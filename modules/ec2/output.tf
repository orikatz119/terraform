output "instance_public_ip" {
    value = aws_instance.test[*].public_ip
}
output "ami_output" {
    value = aws_instance.test[0].ami
    # value = data.aws_ami.ami_global.id
}
