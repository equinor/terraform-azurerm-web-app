# Container application example

Terraform configuration which creates two Azure Web Apps for Containers with the following features:

- Basic SKU (B1)
- HTTPS only
- Azure AD authentication enabled
- Configure Managed Identity for pulling from ACR
- User Assigned Identity enabled
- Send logs to Log Analytics Workspace
