This directory contains unfinished Terraform configuration for creating and managing an AKS cluster.

It was not used in our final deployment for the event.  
One of the primary reasons was that we did not have unrestricted access to the Azure subscription we had access to, and thus (due to [an Azure issue](https://github.com/Azure/AKS/issues/3#issuecomment-611482088)) were unable to effectively automate cluster deployment with Terraform.
