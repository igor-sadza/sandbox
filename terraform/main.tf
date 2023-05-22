resource "null_resource" "main" { 

  # ssh connection block 
  connection {
    type      = "ssh" 
    user      = var.ssh_user 
    password  = var.ssh_pass 
    host      = var.ssh_host 
    port      = var.ssh_port 
  }

  # move to /tmp ~ ansible 
  provisioner "file" {
    source        = "../ansible"
    destination   = "/tmp"
  }

  # install ansible 
  provisioner "remote-exec"  {
    inline = [
      "apt-get update -qq",
      "apt-get install -y -qq ansible"     
    ]
  }
  
  # execute ansible 
  provisioner "local-exec"  {
    command = "ansible-playbook -i ./ansible/inventory/inventory.yml ./ansible/playbooks/install_driver_nvidia.yml" 
    working_dir = "../${path.module}"
  }
}
