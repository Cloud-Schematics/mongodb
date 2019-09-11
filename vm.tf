################################################################
# Module to deploy an VM with specified applications installed
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Licensed Materials - Property of IBM
#
# ©Copyright IBM Corp. 2017.
#
################################################################
variable "hostname" {
  default     = "hostname"
  description = "Hostname for the computing instance."
}

variable "domain" {
  default     = "domain.dev"
  description = "Domain for the computing instance."
}

variable "datacenter" {
  default     = "wdc01"
  description = "Which data center the VM is to be provisioned in. You can run ic cs zones to see a list of all data centers in your region."
}

variable "os_reference_code" {
  default     = "CENTOS_7"
  description = "An operating system reference code that is used to provision the computing instance."
}

variable "cores" {
  default     = "1"
  description = "The number of CPU cores to allocate."
}

variable "memory" {
  default     = "1024"
  description = "The amount of memory to allocate, expressed in MBs."
}

variable "disk_size" {
  default     = "25"
  description = "Numeric disk sizes in GBs."
}

variable "private_network_only" {
  default     = "false"
  description = "When set to true, a compute instance only has access to the private network."
}

variable "network_speed" {
  default     = "100"
  description = "The connection speed (in Mbps) for the instance’s network components."
}

variable "tags" {
  default     = ""
  description = "Set tags on the VM instance."
}

variable "ssh_user" {
  default     = "root"
  description = "The default user for the VM."
}

variable "ssh_label" {
  default     = "public ssh key - Schematics VM"
  description = "An identifying label to assign to the SSH key."
}

variable "ssh_notes" {
  default     = ""
  description = "Notes to store with the SSH key."
}

variable "public_key" {
  description = "Your public SSH key to use for access to the VM."
}

variable "private_key" {
  description = "The private SSH key to use for access to the VM."
}

variable "install_script" {
  default     = "files/installMongoDB.sh"
  description = "The relative location of the Mongo DB install script."
}

variable "script_variables" {
  default     = ""
  description = "The variables to pass into the script."
}

variable "sample_application_url" {
  default     = ""
  description = "The sample application URL."
}

variable "custom_commands" {
  default     = "sleep 1"
  description = "Custom commands to run."
}

resource "ibm_compute_ssh_key" "ssh_key" {
  label      = "${var.ssh_label}"
  notes      = "${var.ssh_notes}"
  public_key = "${var.public_key}"
}

resource "ibm_compute_vm_instance" "vm" {
  hostname                 = "${var.hostname}"
  os_reference_code        = "${var.os_reference_code}"
  domain                   = "${var.domain}"
  datacenter               = "${var.datacenter}"
  network_speed            = "${var.network_speed}"
  hourly_billing           = true
  private_network_only     = "${var.private_network_only}"
  cores                    = "${var.cores}"
  memory                   = "${var.memory}"
  disks                    = ["${var.disk_size}"]
  dedicated_acct_host_only = true
  local_disk               = false
  ssh_key_ids              = ["${ibm_compute_ssh_key.ssh_key.id}"]
  tags                     = ["${var.tags}"]

  connection {
    user        = "${var.ssh_user}"
    private_key = "${var.private_key}"
  }

  # Create the installation script
  provisioner "file" {
    source      = "${var.install_script}"
    destination = "installation.sh"
  }

  # Execute the script remotely
  provisioner "remote-exec" {
    inline = [
      "chmod +x installation.sh",
      "bash installation.sh ${var.sample_application_url} ${var.script_variables}",
      "${var.custom_commands}",
    ]
  }
}

output "public_ip" {
  value = "http://${ibm_compute_vm_instance.vm.ipv4_address}"
}
