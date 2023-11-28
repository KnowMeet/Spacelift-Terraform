module "networking" {
  source = "./networking" 

}

module "compute" {
  source = "./compute"
  security_group_id = [module.networking.security_group_id]
  subnet_id = module.networking.subnet_id
  host_os = var.host_os
  node_name = "Yuvi"
  key_name = "Yuvi-Key"
  instance_type = "t2.micro"
}


module "Simran" {
  source = "./compute"
  security_group_id = [module.networking.security_group_id]
  subnet_id = module.networking.subnet_id
  host_os = var.host_os
  node_name = "Simran"
  key_name = "Simran-Key"
  instance_type = "t2.micro"
}

