provider "vsphere" {
  user                 = "${var.vsphere_user}"
  password             = "${var.vsphere_password}"
  vsphere_server       = "${var.vsphere_server}"
  allow_unverified_ssl = true
}

data "vsphere_datacenter" "dc" {
  name = "${var.dc_name}"
}

## If you use datastore clusters (RDS) please comment out the following 4 lines and uncomment the 4 after that.
## Please note you'll also need to comment out the datastore_id line in the vsphere_virtual_machine resource block and
## uncomment the datastore_cluster_id line.
data "vsphere_datastore" "datastore" {
  name          = "${var.datastore_name}"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

#data "vsphere_datastore_cluster" "datastore_cluster" {
#  name          = "${var.datastore_cluster_name}"
#  datacenter_id = "${data.vsphere_datacenter.dc.id}"
#}

## For use without an explicitly created resource pool. If you do use resource pools, please comment out the 4 lines below.
#data "vsphere_resource_pool" "pool" {
#  name          = "cluster1/Resources"
#  datacenter_id = "${data.vsphere_datacenter.dc.id}"
#}

## For use with a specific resource pool
data "vsphere_resource_pool" "pool" {
  name          = "${var.resourcepool_name}"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_network" "network" {
  name          = "${var.network_name}"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_virtual_machine" "template" {
  name          = "${var.template_name}"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

resource "vsphere_virtual_machine" "vm" {
  name             = "${var.hostname}"
  resource_pool_id = "${data.vsphere_resource_pool.pool.id}"
  datastore_id     = "${data.vsphere_datastore.datastore.id}"

  #datastore_cluster_id    = "${data.vsphere_datastore_cluster.datastore_cluster.id}"

  num_cpus  = 2
  memory    = 8192
  guest_id  = "${data.vsphere_virtual_machine.template.guest_id}"
  scsi_type = "${data.vsphere_virtual_machine.template.scsi_type}"
  network_interface {
    network_id   = "${data.vsphere_network.network.id}"
    adapter_type = "${data.vsphere_virtual_machine.template.network_interface_types[0]}"
  }
  disk {
    label            = "disk0"
    size             = "${data.vsphere_virtual_machine.template.disks.0.size}"
    eagerly_scrub    = "${data.vsphere_virtual_machine.template.disks.0.eagerly_scrub}"
    thin_provisioned = "${data.vsphere_virtual_machine.template.disks.0.thin_provisioned}"
  }
  clone {
    template_uuid = "${data.vsphere_virtual_machine.template.id}"

    customize {
      linux_options {
        host_name = "${var.hostname}"
        domain    = "${var.domain}"
      }

      network_interface {
        ipv4_address = "${var.ipaddress}"
        ipv4_netmask = "${var.netmask}"
        #dns_server_list = "[${var.dns}]"
      }

      ipv4_gateway = "${var.gateway}"
    }
  }

  #provisioner "remote-exec" {
  #  inline = [
  #    "mkdir /tmp/ptfe-install",
  #    ]
  #}
  #
  #provisioner "file" {
  #  source      = "${var.json_location}"
  #  destination = "/tmp/ptfe-install/settings.json"
  #}
  #
  #provisioner "file" {
  #  source      = "${var.replicated_conf}"
  #  destination = "/etc/replicated.conf"
  #}
  #
  #provisioner "file" {
  #  source      = "${var.license}"
  #  destination = "/tmp/ptfe-install/license.rli"
  #}
  #
  #provisioner "file" {
  #  source      = "application-install/replicated-install.sh"
  #  destination = "/tmp/ptfe-install/replicated-install.sh"
  #}
  #
  #provisioner "remote-exec" {
  #  inline = [
  #    "chmod +x /tmp/ptfe-install/replicated-install.sh",
  #    "/tmp/ptfe-install/replicated-install.sh",
  #    ]
  #}
}

output "hostname" {
  value = "${var.hostname}.${var.domain}"
}
