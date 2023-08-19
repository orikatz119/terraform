
module "vpc_local_module" {
  source = "./modules/vpc"
  vpc_region = var.vpc_region
}

module "ec2-instance" {
  source = "./modules/ec2"
    vpc_region = var.vpc_region
    vpc_local_id = module.vpc_local_module.vpc_id
    subnet_local_id = module.vpc_local_module.subnet
    # its check if kubeadm create is true and also if the region is eu-central-1
    kubeadm_build = var.kubeadm  && var.vpc_region == "eu-central-1" ? true : false
}
