// provider "azurerm" {
//   # Whilst version is optional, we /strongly recommend/ using it to pin the version of the Provider being used
//   version = "=1.20.0"
// }

// provider "azurerm" {
//   # Whilst version is optional, we /strongly recommend/ using it to pin the version of the Provider being used
//   version = "=1.27.0"

//   subscription_id = "5f0c2a96-d8f0-4435-a62a-832308b6b476"
//   #tenant_id       = "11111111-1111-1111-1111-111111111111"
// }
// https://portal.azure.com/#blade/Microsoft_AAD_IAM/ActiveDirectoryMenuBlade/RegisteredApps/RegisteredApps/Overview
// Display name :
// terraform
// Application (client) ID: 10d5b773-b9f5-48ac-ba26-ea6e59be6bb7
// Directory (tenant) ID: 5f0c2a96-d8f0-4435-a62a-832308b6b476
// Object ID: 591d6a95-c2cc-4dfc-86d9-88a07b8b30e7

// variable "client_certificate_path" {}
// variable "client_certificate_password" {}

// provider "azurerm" {
//  # Whilst version is optional, we /strongly recommend/ using it to pin the version of the Provider being used
//  version = "=1.27.0"
//
//   subscription_id             = "00000000-0000-0000-0000-000000000000"
//   client_id                   = "00000000-0000-0000-0000-000000000000"
//   client_certificate_path     = "${var.client_certificate_path}"
//   client_certificate_password = "${var.client_certificate_password}"
//   tenant_id                   = "00000000-0000-0000-0000-000000000000"
// }
// data "azurerm_subscription" "current" {}

// resource "azurerm_virtual_machine" "test" {
//   # ...

//   identity = {
//     type = "SystemAssigned"
//   }
// }

// data "azurerm_builtin_role_definition" "contributor" {
//   name = "Contributor"
// }

// resource "azurerm_role_assignment" "test" {
//   name               = azurerm_virtual_machine.test.name
//   scope              = data.azurerm_subscription.primary.id
//   role_definition_id = "${data.azurerm_subscription.subscription.id}${data.azurerm_builtin_role_definition.contributor.id}"
//   principal_id       = lookup(azurerm_virtual_machine.test.identity[0], "principal_id")
// }

provider "azurerm" {
  # The "feature" block is required for AzureRM provider 2.x.
  # If you are using version 1.x, the "features" block is not allowed.
  version = "~>2.0"
  features {}
}
resource "azurerm_resource_group" "rg" {
  name     = "testResourceGroup"
  location = "westus"
}

# Create a resource group if it doesn't exist
resource "azurerm_resource_group" "myterraformgroup" {
  name     = "myResourceGroup"
  location = "eastus"

  tags = {
    environment = "Terraform Demo"
  }
}

# Create virtual network
resource "azurerm_virtual_network" "myterraformnetwork" {
  name                = "myVnet"
  address_space       = ["10.0.0.0/16"]
  location            = "eastus"
  resource_group_name = azurerm_resource_group.myterraformgroup.name

  tags = {
    environment = "Terraform Demo"
  }
}

# Create subnet
resource "azurerm_subnet" "myterraformsubnet" {
  name                 = "mySubnet"
  resource_group_name  = azurerm_resource_group.myterraformgroup.name
  virtual_network_name = azurerm_virtual_network.myterraformnetwork.name
  address_prefix       = "10.0.1.0/24"
}

# Create public IPs
resource "azurerm_public_ip" "myterraformpublicip" {
  name                = "myPublicIP"
  location            = "eastus"
  resource_group_name = azurerm_resource_group.myterraformgroup.name
  allocation_method   = "Dynamic"

  tags = {
    environment = "Terraform Demo"
  }
}

# Create Network Security Group and rule
resource "azurerm_network_security_group" "myterraformnsg" {
  name                = "myNetworkSecurityGroup"
  location            = "eastus"
  resource_group_name = azurerm_resource_group.myterraformgroup.name

  security_rule {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = {
    environment = "Terraform Demo"
  }
}

# Create network interface
resource "azurerm_network_interface" "myterraformnic" {
  name                = "myNIC"
  location            = "eastus"
  resource_group_name = azurerm_resource_group.myterraformgroup.name

  ip_configuration {
    name                          = "myNicConfiguration"
    subnet_id                     = azurerm_subnet.myterraformsubnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.myterraformpublicip.id
  }

  tags = {
    environment = "Terraform Demo"
  }
}

# Connect the security group to the network interface
resource "azurerm_network_interface_security_group_association" "example" {
  network_interface_id      = azurerm_network_interface.myterraformnic.id
  network_security_group_id = azurerm_network_security_group.myterraformnsg.id
}

# Generate random text for a unique storage account name
resource "random_id" "randomId" {
  keepers = {
    # Generate a new ID only when a new resource group is defined
    resource_group = azurerm_resource_group.myterraformgroup.name
  }

  byte_length = 8
}

# Create storage account for boot diagnostics
resource "azurerm_storage_account" "mystorageaccount" {
  name                     = "diag${random_id.randomId.hex}"
  resource_group_name      = azurerm_resource_group.myterraformgroup.name
  location                 = "eastus"
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = "Terraform Demo"
  }
}

# Create virtual machine
resource "azurerm_linux_virtual_machine" "myterraformvm" {
  name                  = "myVM_"
  location              = "eastus"
  resource_group_name   = azurerm_resource_group.myterraformgroup.name
  network_interface_ids = [azurerm_network_interface.myterraformnic.id]
  size                  = "Standard_DS1_v2"

  os_disk {
    name                 = "myOsDisk"
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04.0-LTS"
    version   = "latest"
  }

  computer_name                   = "myvm"
  admin_username                  = "azureuser"
  disable_password_authentication = true

  admin_ssh_key {
    username   = "azureuser"
    public_key = file("/Users/abuxton/.ssh/abuxton_id_rsa.pub")
  }

  boot_diagnostics {
    storage_account_uri = azurerm_storage_account.mystorageaccount.primary_blob_endpoint
  }

  tags = {
    environment = "Terraform Demo"
  }
}
