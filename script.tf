resource "null_resource" "init" {

  connection {
    type 	= "ssh" 
    user 	= var.user 
    password  	= var.pass 
    host 	= var.host 
    port 	= var.port 
  }

  provisioner "remote-exec" {
    inline = [
      "echo DD",
      "echo DD"
    ]
  }
}
