# instance settings
resource "aws_instance" "test" {
  # with func element We choose which element in the array we will use on the first argument 
  # using a Boolean condition found in the second argument.
  instance_type = element(var.type_instance, var.kubeadm_build ? 1 : 0)

  # if kubeadm_build is true, the AMI will be one with the kubeadm pre installed. else it will be a regular AMI
  ami = var.kubeadm_build ? "ami-02260441a7666f848" : "${data.aws_ami.ami_global.id}"
  
  key_name = var.key_pair_name
  vpc_security_group_ids = ["${aws_security_group.mysg.id}"]
  associate_public_ip_address = true
  subnet_id = var.subnet_local_id[count.index]
  tags = {
    Name = "Terraform instance-${var.alphabet[count.index]}"
  }
  count = var.iterations
}


# SG settings
resource "aws_security_group" "mysg" {
  name        = "SG-Terraform"
  description = "Allow SSH and HTTP inbound traffic"
  vpc_id      = var.vpc_local_id

  dynamic "ingress" {
  for_each =  var.kubeadm_build ?  tolist([0]) : var.project_ports
  content {
    from_port   = ingress.value
    to_port     = ingress.value
    protocol    = var.kubeadm_build ? -1 : "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    # ipv6_cidr_blocks = ["::/0"]
  }
}

# Key Pair settings
resource "aws_key_pair" "key-pair-terraform" {
  key_name   = var.key_pair_name
  public_key = file("../keys/terraform.pub")
}