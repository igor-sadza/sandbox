resource "null_resource" "main" { 
  
  # execute ansible 
  provisioner "local-exec"  {
    command = "ansible-playbook -e 'ANSIBLE_CONFIG=./ansible/ansible.cfg' -i ./ansible/inventory/inventory.yml ./ansible/playbooks/install_driver_nvidia.yml" 
    working_dir = "../${path.module}"
  }
}
