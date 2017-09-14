variable "public_key" {
    default = "$SCHEMATICS.SSHKEYPUBLIC"
}
variable "private_key" {
    default = "$SCHEMATICS.SSHKEYPRIVATE"
}

module "mongodb" {
    source = "github.com/Cloud-Schematics/terraform-modules/ibm/vm"
    public_key = "${var.public_key}"
    install_script = "files/installMongoDB.sh"
    script_variables = false
    private_key = "${var.private_key}"
}