variable "ssh_key" {}
module "mongodb" {
    source = "../terraform-modules/ibm/vm"
    public_key = "${var.ssh_key}"
    install_script = "files/installMongoDB.sh"
    script_variables = false
    temp_private_key = "${file("~/.ssh/id_rsa.pem")}"
}