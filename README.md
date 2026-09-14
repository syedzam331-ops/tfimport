Terraform Azure Import

This document describes the workflow for importing existing Azure resources into Terraform using Azure CLI, aztfexport, and Terraform.

The goal is to export/import existing Azure resources into Terraform-managed configuration, review the generated files, verify that Terraform detects no unexpected changes, and then commit the configuration to Git.

1. Prerequisites

The following tools are required on the local machine:

Azure CLI
Terraform CLI
Azure Export for Terraform (aztfexport)
Git
VS Code (recommended)
1.1 Install Azure CLI

On Windows, install Azure CLI using Winget:

winget install --exact --id Microsoft.AzureCLI


Verify the installation:

az --version

1.2 Install Terraform

Install Terraform CLI if it is not already installed.

For example, using Winget:

winget install --exact --id Hashicorp.Terraform


Verify the installation:

terraform -version

1.3 Install Azure Export for Terraform

aztfexport is used to export existing Azure resources and generate Terraform configuration/import information.

First, check whether the package is available through Winget:

winget search aztfexport


You should see something similar to:

Name                                 Id                         Version Match               Source
--------------------------------------------------------------------------------------------------
Microsoft Azure Export for Terraform Microsoft.Azure.AztfExport 0.20.0  Moniker: aztfexport winget


Install it using:

winget install --exact --id Microsoft.Azure.AztfExport


Verify the installation:

aztfexport --version


Note: Homebrew is not required when using Winget on Windows. If you are using macOS, Homebrew can be used instead.

1.4 Install Git

If Git is not already installed:

winget install --exact --id Git.Git


Verify:

git --version

2. Quick Prerequisites Recap

For Windows, the basic installation commands are:

# Azure CLI
winget install --exact --id Microsoft.AzureCLI

# Terraform
winget install --exact --id Hashicorp.Terraform

# Azure Export for Terraform
winget install --exact --id Microsoft.Azure.AztfExport

# Git
winget install --exact --id Git.Git


Verify everything:

az --version
terraform -version
aztfexport --version
git --version

3. Login to Azure

Open the VS Code integrated terminal:

Ctrl + `


Then run:

az login


This will open a browser where you can authenticate with your Azure account.

After login, check the available subscriptions:

az account list -o table


Example:

Name                 CloudName    SubscriptionId                         State
-------------------  -----------  --------------------------------------  --------
Development          AzureCloud   xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx   Enabled
Production           AzureCloud   xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx   Enabled


If you have multiple subscriptions, explicitly select the subscription that contains the resources you want to import:

az account set --subscription "<subscription-name-or-id>"


Verify the currently selected subscription:

az account show -o table


Important: Always verify the active subscription before running the import. Importing from the wrong subscription can result in exporting the wrong resources.

4. Check Existing Azure Resources

Before starting the Terraform import, it is useful to understand what resources currently exist in the target resource group.

Run:

az resource list --resource-group <rg-name> -o table


For example:

az resource list --resource-group my-production-rg -o table


This provides a quick overview of the resources present in the resource group.

You can use this command to answer questions such as:

How many resources are present?
What types of resources exist?
Which resources need to be imported?
Are there resources that should be excluded from Terraform management?
5. Create the Terraform Project

Create a dedicated folder for the Terraform import project.

Example:

terraform-azure-import/


Open the folder in VS Code.

Recommended initial structure:

terraform-azure-import/
├── providers.tf
├── main.tf
├── variables.tf
├── prod.tfvars
├── uat.tfvars
└── README.md


The structure can be adjusted later depending on the project's requirements.

6. Install VS Code Extensions

The following VS Code extensions are recommended:

HashiCorp Terraform — official Terraform extension
Azure Account — useful for Azure account/resource access
Azure Resources — useful for browsing Azure resources

The HashiCorp Terraform extension provides:

Terraform syntax highlighting
Formatting
Validation
Terraform language support
Editor integration
7. Configure Terraform Provider

Create a providers.tf file.

A basic AzureRM provider configuration can look like:

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }

  required_version = ">= 1.5.0"

  # Configure the backend according to your organization's requirements.
  # backend "azurerm" {
  #   ...
  # }
}

provider "azurerm" {
  features {}
}


Important: For a shared or production Terraform project, use a remote backend such as Azure Storage for Terraform state rather than keeping the state only on the local machine.

The exact backend configuration should follow your organization's existing Terraform/state-management standards.

8. Initialize Terraform

From the project directory, run:

terraform init


Terraform will:

Initialize the working directory
Download required providers
Configure the backend if one is configured
Prepare the directory for Terraform operations

After initialization, you should see a successful initialization message.

9. Use aztfexport for Bulk Import

For bulk importing existing Azure resources, use:

aztfexport


For example, to export a resource group:

aztfexport resource-group <rg-name>


Example:

aztfexport resource-group my-production-rg


The tool will inspect the Azure resources in the specified resource group and generate Terraform configuration/import information.

The generated Terraform files should then be reviewed and cleaned up before they are treated as production Terraform code.

10. Review the Generated Terraform Files

After running aztfexport, inspect the generated .tf files in VS Code.

Review the following carefully:

Resource configuration

Check that all expected Azure resources were exported.

Resource names

Verify that Terraform resource names are meaningful and follow the project's naming conventions.

Dependencies

Check dependencies between resources.

Variables

Move environment-specific values into variables where appropriate.

Sensitive information

Make sure secrets, passwords, connection strings, keys, or other sensitive values are not accidentally committed to Git.

Provider configuration

Ensure that the generated configuration uses the correct AzureRM provider configuration.

Backend configuration

Ensure Terraform state is stored in the organization's approved remote backend.

11. Run Terraform Formatting

Format the Terraform files:

terraform fmt


To check formatting without modifying files:

terraform fmt -check

12. Validate the Terraform Configuration

Run:

terraform validate


This checks whether the Terraform configuration is syntactically and structurally valid.

A successful validation should return something similar to:

Success! The configuration is valid.

13. Run Terraform Plan

After reviewing the generated configuration, run:

terraform plan


The purpose of the plan is to verify that Terraform's configuration and state correctly represent the existing Azure environment.

Ideally, after the import and cleanup process, Terraform should not propose unexpected changes to existing resources.

Pay special attention to plans containing:

+ create
~ update
- destroy
-/+ replace


Do not blindly apply a plan that contains unexpected changes.

Investigate the differences first.

14. Git Initialization

Once the generated Terraform configuration has been reviewed:

git init


Check the repository:

git status

15. Create a .gitignore

Create a .gitignore file in the project root.

A basic example:

# Terraform
.terraform/
*.tfstate
*.tfstate.*
crash.log
crash.*.log

# Terraform variable files
*.tfvars
*.tfvars.json

# Terraform plan files
*.tfplan
*.plan

# Local override files
override.tf
override.tf.json
*_override.tf
*_override.tf.json

# VS Code
.vscode/

# OS files
.DS_Store
Thumbs.db


Important: Do not automatically ignore every .tfvars file if your project intentionally stores non-sensitive environment configuration in Git. Review the contents first and follow your organization's security policy.

16. Review Git Changes

Run:

git status


Review the files that will be committed.

You can inspect the changes using:

git diff


Make sure that:

No secrets are committed
No passwords are committed
No access keys are committed
No connection strings containing credentials are committed
Terraform state files are not committed
The generated Terraform configuration has been reviewed
17. Commit the Terraform Configuration

Once everything has been reviewed:

git add .


Create the initial commit:

git commit -m "Import existing Azure resources into Terraform"

18. Complete Workflow

The complete workflow can be summarized as:

1. Install required tools
        ↓
2. Login to Azure
        ↓
3. Select the correct Azure subscription
        ↓
4. Check resources in the target Resource Group
        ↓
5. Create/open Terraform project
        ↓
6. Configure Terraform provider/backend
        ↓
7. Run terraform init
        ↓
8. Run aztfexport
        ↓
9. Review generated Terraform files
        ↓
10. Run terraform fmt
        ↓
11. Run terraform validate
        ↓
12. Run terraform plan
        ↓
13. Fix unexpected differences
        ↓
14. Initialize Git
        ↓
15. Review .gitignore and sensitive information
        ↓
16. Commit Terraform configuration

19. Quick Command Reference
Azure
# Login
az login

# List subscriptions
az account list -o table

# Select subscription
az account set --subscription "<subscription-name-or-id>"

# Verify selected subscription
az account show -o table

# List resources in a resource group
az resource list --resource-group <rg-name> -o table

Terraform
# Initialize
terraform init

# Format
terraform fmt

# Validate
terraform validate

# Create execution plan
terraform plan

aztfexport
# Check version
aztfexport --version

# Export a resource group
aztfexport resource-group <rg-name>

Git
# Initialize repository
git init

# Check status
git status

# Review changes
git diff

# Stage files
git add .

# Commit
git commit -m "Import existing Azure resources into Terraform"

20. Important Notes
Subscription

Always verify the active Azure subscription before starting an import:

az account show -o table


This is especially important when your Azure account has access to multiple subscriptions.

Resource Group

The resource group passed to aztfexport should be the intended resource group for the import:

aztfexport resource-group <rg-name>

Terraform State

Terraform state is critical. For shared environments and production workloads, use an approved remote backend rather than relying on local state.

Generated Configuration

aztfexport helps generate Terraform configuration, but the generated files should not automatically be considered final production-ready Terraform code.

Always review, clean up, organize, and validate the generated configuration.

Secrets

Never commit credentials, secrets, access keys, passwords, or sensitive Terraform state to Git.

Plan Before Apply

Do not run:

terraform apply


until the output of:

terraform plan


has been carefully reviewed and the proposed changes are understood.

21. Recommended Project Structure

For the initial import:

terraform-azure-import/
├── providers.tf
├── main.tf
├── variables.tf
├── prod.tfvars
├── uat.tfvars
├── .gitignore
└── README.md


As the project grows, consider separating environments and reusable modules:

terraform-azure/
├── modules/
│   ├── resource-group/
│   ├── storage/
│   ├── virtual-network/
│   └── ...
│
├── environments/
│   ├── prod/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── terraform.tfvars
│   │
│   └── uat/
│       ├── main.tf
│       ├── variables.tf
│       └── terraform.tfvars
│
├── providers.tf
├── .gitignore
└── README.md
