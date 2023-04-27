# Virtual network integration example

Terraform configuration which creates an Azure Web App and integrates it with an Azure virtual network.

## Notes

- Microsoft recommends using a `/26` subnet mask when creating a subnet for VNet integration, to avoid any issues with subnet capacity ([ref.](https://learn.microsoft.com/en-us/azure/app-service/overview-vnet-integration#subnet-requirements)).
