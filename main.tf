provider "vsphere" {
  user                 = var.user
  password             = var.password
  vsphere_server       = var.server
  allow_unverified_ssl = true

}

data "vsphere_datacenter" "dc" {
  name = "dc"

}
data "vsphere_resource_pool" "rp" {
  name          = ""
  datacenter_id = data.vsphere_datacenter.dc.id

}
data "vsphere_network" "nt" {
  name          = "Network 2"
  datacenter_id = data.vsphere_datacenter.dc.id

}
resource "vsphere_virtual_machine" "vm1" {
  name             = "vm-test"
  resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id     = data.vsphere_datastore.datastore.id
  num_cpus         = 1
  memory           = 1024
  guest_id         = "other3xLinux64Guest"
  network_interface {
    network_id = data.vsphere_network.network.id
  }
  disk {
    label = "disk0"
    size  = 20
  }
}
  
