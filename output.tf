output "instance_public_ip" {
    value = module.ec2-instance.instance_public_ip
}
output "ami_output" {
    value = module.ec2-instance.ami_output
}
