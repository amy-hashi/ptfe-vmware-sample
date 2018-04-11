# The vSphere server hostname or IP to connect to
vsphere_server = "amy-vcsa.hashicorp-success.com"

# The name of the datacenter you will be deploying pTFE into
dc_name = "Packet-CA"

# The name of the datastore you want to use. Comment these lines out if you use datastore clusters
datastore_name = "datastore1"

# If you use datastore clusters (RDS) please use this variable instaed of datastore_name
#datastore_cluster_name = ""

# Uncomment if you use resource pools
resourcepool_name = "default"

# The name of the vm network where you want to deploy pTFE
network_name = "VM Network"

# The name of the template you will use as a base for pTFE
template_name = "ubuntu"

# The name of the pTFE host, without the domain. Example: "ptfe"
hostname = "amy-ptfe"

# The fully qualified domain mame of the pTFE server. Example: "ptfe.customer.com"
domain = "hashicorp-success.com"

# The IP Address of the server. Example: "10.0.0.100"
ipaddress = "147.75.202.197"

# The netmask of the server. Example: "24"
netmask = "29"

# The Gateway address of the server. Example: "10.0.0.1"
gateway = "147.75.202.193"

# DNS Server to use
dns = ["1.1.1.1","1.0.0.1"]

# Path to the settings json on the system you are running this from
#json_location = "application-install/settings.json"

# Path to the replicated.conf file on the system you are running this from
#replicated_conf = "application-install/replicated.conf"

# Path to the license file on the system you are running this from
#license = "application-install/amy.rli"