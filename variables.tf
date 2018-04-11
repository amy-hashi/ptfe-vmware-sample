variable "vsphere_user" {}
variable "vsphere_password" {}
variable "vsphere_server" {}

# The name of the datacenter you will be deploying pTFE into
variable "dc_name" {}

# The name of the datastore you want to use. Comment these lines out if you use datastore clusters
variable "datastore_name" {}

# If you use datastore clusters (RDS) please use this variable instaed of datastore_name
#variable "datastore_cluster_name" {}

## Uncomment if you use resource pools
variable "resourcepool_name" {}

# The name of the vm network were you want to deploy pTFE
variable "network_name" {}

# The name of the template you will use as a base for pTFE
variable "template_name" {}

# The name of the pTFE host, without the domain. Example: "ptfe"
variable "hostname" {}

# The domain mame of the pTFE server. Example: "customer.com"
variable "domain" {}

# The IP Address of the server and CIDR block. Example: "10.0.0.100"
variable "ipaddress" {}

# The netmask of the server in CIDR block. Example: "24"
variable "netmask" {}

# The Gateway address of the server. Example: "10.0.0.1"
variable "gateway" {}
#variable "dns" {}

#variable "json_location" {}
#variable "replicated_conf" {}
#variable "license" {}

