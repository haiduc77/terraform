Azure App Service enables you to build and host web apps, mobile back ends, and RESTful APIs in the programming language of your choice without managing infrastructure. 
It offers auto-scaling and high availability, supports both Windows and Linux, and enables automated deployments from GitHub, Azure DevOps, or any Git repo. For this project I created a GitHub repo.
In terms of security, the platform components of App Service, including Azure VMs, storage, network connections, web frameworks, management and integration features, are actively secured and hardened. 
App Service lets you secure your apps with HTTPS. When the app is created, its default domain name (<app_name>.azurewebsites.net) is already accessible using HTTPS.
It can also be secured with a TLS/SSL certificate so that client browsers can make secured HTTPS connections
For the automation part I used Terraform. The first line on the Terraform code was naming the Azure as the provider and the creation of a resource group in the West Europe region.
I deployed a windows app service plan with pricing tier Standar S1 which was required in order to have the app service itself. 
The source control flag was added in order to use the GitHub repo.
Standard S1 pricing tier was selected because it is offering high availability, scalability and security features.
In addition, I created an sql server on which I added a new sql database. For High Availability purposes, I used Zone Redundant Storage which copies the data synchronously across three Azure availability zones in the primary region.
The Terraform corde contains several files. The main.tf which contains the entire code, the variables.tf on which I entered the variables "prefix" which is used for naming the resources and "location" which determine the location on which all the resources from this project will be deployed.
The last file is the terraform.tfvars on which I declared the variables mentioned above.