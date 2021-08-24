#list required providers

resource "metalcloud_infrastructure" "management" {
  
  infrastructure_label = "management-2"
  datacenter_name = var.datacenter

  # Remove this to actually deploy changes, otherwise all changes will remain in edit mode only.
  prevent_deploy = true 
  
  #these options will make terraform apply operation will wait for the deploy to finish (when prevent_deploy is false) 
  #instead of exiting while the deploy is ongoing
  await_deploy_finished = true
  await_delete_finished = true 
  
  #this option disables a safety check that metalsoft performs to prevent accidental data loss
  #it is required when testing delete operations
  allow_data_loss = true
 
  network {
      network_type = "wan"
      network_label = "data-network"
  }

  network {
      network_type = "san"
      network_label = "storage-network"
  }

  #FIRST GROUP
 
  instance_array {
    # Name of your cluster. Needs to obey DNS rules as it will translate into a DNS record.
    instance_array_label = "esxi-group1-1"

    instance_array_instance_count = 1
    instance_array_ram_gbytes = 2
    instance_array_processor_count = 1
    instance_array_processor_core_count = 2

    instance_array_boot_method = "local_drives"
    volume_template_id = tonumber(data.metalcloud_volume_template.esxi7.id)

    instance_array_firewall_managed = false

   # interface{
   # 	interface_index = 0
   #   network_label = "data-network"
   # }

   # interface{
   # 	interface_index = 1
   #   network_label = "data-network"
   # }

   # interface{
   #  	interface_index = 2
   #   network_label = "storage-network"
   # }

   # interface{
   # 	interface_index = 3
   #   network_label = "storage-network"
   # }

    instance_array_additional_wan_ipv4_json = jsonencode(
                {
                   configs = [
                       {
                           forced_subnet_pool_id = 8
                           override_vlan_id      = 300
                        },
                       {
                           forced_subnet_pool_id = 9
                           override_vlan_id      = 301
                        },
                       {
                           forced_subnet_pool_id = 10
                           override_vlan_id      = 900
                        },
                           {
                           forced_subnet_pool_id = 10
                           override_vlan_id      = 15
                        }, 
                        {
                           forced_subnet_pool_id = 11
                           override_vlan_id      = 16
                        },
                    ]
                }
            )
  }

  instance_array {
    # Name of your cluster. Needs to obey DNS rules as it will translate into a DNS record.
    instance_array_label = "esxi-group1-2"

    instance_array_instance_count = 1
    instance_array_ram_gbytes = 2
    instance_array_processor_count = 1
    instance_array_processor_core_count = 2

    volume_template_id = tonumber(data.metalcloud_volume_template.esxi7.id)

    instance_array_firewall_managed = false

    # interface{
    # 	interface_index = 0
    #   network_label = "data-network"
    # }

    # interface{
    # 	interface_index = 1
    #   network_label = "data-network"
    # }

    # interface{
    #  	interface_index = 2
    #   network_label = "storage-network"
    # }

    # interface{
    # 	interface_index = 3
    #   network_label = "storage-network"
    # }

    
     instance_array_additional_wan_ipv4_json = jsonencode(
                {
                   configs = [
                       {
                           forced_subnet_pool_id = 8
                           override_vlan_id      = 300
                        },
                       {
                           forced_subnet_pool_id = 9
                           override_vlan_id      = 301
                           external_connections = ["uplink1"]
                        },
                       {
                           forced_subnet_pool_id = 10
                           override_vlan_id      = 900
                           external_connections = ["uplink1"]
                        },
                    ]
                }
            )
  }



  shared_drive {
    shared_drive_label = "my-shared-drive"
    shared_drive_size_mbytes = 4000965
    shared_drive_storage_type = "iscsi_hdd"
    shared_drive_attached_instance_arrays = ["esxi-group1-1","esxi-group1-2"]
  }
  
}




