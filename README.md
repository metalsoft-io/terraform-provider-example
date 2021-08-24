# terraform-provider-example

This example configures a management infrastructure and two 'tenant' infrastructures.

## Required versions 
* Terraform v1.0.4
* MetalCloud provider 1.0.13


## Usage
To use add the user's email address and API key retrieved from the user interface in the variables.tf files on each sub directory.

Then descend in each directory and use 
```
terrafrom init
terraform apply
```

To retrieve credentials, ips and other details of the provisioned infrastructure use:
```
terraform output
```

## Documentation

* [Getting Started](https://registry.terraform.io/providers/metalsoft-io/metalcloud/latest/docs/guides/getting_started)
* [Infrastructure resource](https://registry.terraform.io/providers/metalsoft-io/metalcloud/latest/docs/resources/infrastructure)
* [Instance Array resource](https://registry.terraform.io/providers/metalsoft-io/metalcloud/latest/docs/resources/instance_array)
