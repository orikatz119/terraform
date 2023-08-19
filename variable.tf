variable "vpc_region" {
  #default = "eu-west-1"
  type = string
}
variable "kubeadm" {
  type = bool
  description = <<EOF
    Build Kubeadm cluster for now Enter true only if you used in 
    eu-central-1 region!!!.
    EOF 
}