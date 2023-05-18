resource "null_resource" "main" { 

  # ssh connection block 
  connection {
    type      = "ssh" 
    user      = var.ssh-user 
    password  = var.ssh-pass 
    host      = var.ssh-host 
    port      = var.ssh-port 
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
      "apt install software-properties-common",
      "apt-add-repository ppa:ansible/ansible",
      "apt-get install -y -qq ansible",     
    ]
  }
  
  # execute ansible 
  provisioner "remote-exec"  {
    inline = [
      "ansible-playbook -i localhost, /tmp/ansible/playbooks/install_driver_nvidia.yml"
    ]
  }
}
