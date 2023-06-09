#Provision the app onto the system
resource "null_resource" "provisioners" { 

  # move scripts to /tmp 
  provisioner "file" {
    source = "scripts"
    destination = "/tmp"
    connection {
      type = "ssh" 
      user = var.user 
      password = var.pass 
      host = var.host 
      port = var.port 
    }
  }

  # initial setup
  provisioner "remote-exec"  {
    inline = [
      "set -e",
      "chmod +x /tmp/scripts*/*",
      "/tmp/scripts/install_gpu_drivers.sh"
    ]
    connection {
      type = "ssh" 
      user = var.user 
      password = var.pass 
      host = var.host 
      port = var.port 
    }
  }
}
