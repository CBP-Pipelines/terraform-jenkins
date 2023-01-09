provider "vsphere" {
  user                 = var.user
  password             = var.password
  vsphere_server       = var.server
  allow_unverified_ssl = true

}

data "vsphere_datacenter" "dc" {
  name = var.datacenter_name

}
data "vsphere_resource_pool" "rp" {
  name          = var.resource_pool_name
  datacenter_id = data.vsphere_datacenter.dc.id

}
data "vsphere_network" "nt" {
  name          = var.network_interface
  datacenter_id = data.vsphere_datacenter.dc.id

}
resource "vsphere_virtual_machine" "vm1" {
  name             = "vm-test"
  resource_pool_id = data.vsphere_resource_pool.rp.id
  num_cpus         = 1
  memory           = 1024
  guest_id         = "other3xLinux64Guest"
  network_interface {
    network_id = data.vsphere_network.nt.id
  }
  disk {
    label = "disk0"
    size  = 20
  }
}
  
