output "credentials" {
   description = "the credentials of instances"
   sensitive = true
   value = {
     for k, ia in  metalcloud_infrastructure.tenant1.instance_array.* :  ia.instance_array_label => 
     {  for ilabel,i  in jsondecode("${ia.instances}"): ilabel => i.instance_credentials }
   }
}