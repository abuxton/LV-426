resource "azurerm_resource_group" "new-rg" {
  name     = "$new-{var.prefix}-rg"
  location = var.location
}
resource "azurerm_virtual_network" "new_vnet" {
  name                = "${var.prefix}-VNet"
  address_space       = ["10.42.0.0/16"]
  location            = var.location
  resource_group_name = azurerm_resource_group.new_rg.name
}
# Create subnet
resource "azurerm_subnet" "new_subnet" {
  name                 = "${var.prefix}-Subnet"
  resource_group_name  = azurerm_resource_group.new_rg.name
  virtual_network_name = azurerm_virtual_network.new_vnet.name
  address_prefixes     = ["10.42.1.0/24"]
}

# Create public IP
resource "azurerm_public_ip" "new_publicip" {
  name                = "${var.prefix}-PublicIP"
  location            = var.location
  resource_group_name = azurerm_resource_group.new_rg.name
  allocation_method   = "Static"
}


# Create Network Security Group and rule
resource "azurerm_network_security_group" "new_nsg" {
  name                = "${var.prefix}-NSG"
  location            = var.location
  resource_group_name = azurerm_resource_group.new_rg.name

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
}

# Create network interface
resource "azurerm_network_interface" "new_nic" {
  name                = "${var.prefix}-NIC"
  location            = var.location
  resource_group_name = azurerm_resource_group.new_rg.name

  ip_configuration {
    name                          = "${var.prefix}-NICconfig"
    subnet_id                     = azurerm_subnet.new_subnet.id
    private_ip_address_allocation = "dynamic"
    public_ip_address_id          = azurerm_public_ip.new_publicip.id
  }
}

# Create a Linux virtual machine
resource "azurerm_virtual_machine" "new_vm" {
  name                  = "${var.prefix}-VM"
  location              = var.location
  resource_group_name   = azurerm_resource_group.new_rg.name
  network_interface_ids = [azurerm_network_interface.new_nic.id]
  vm_size               = "Standard_DS1_v2"

  storage_os_disk {
    name              = "${var.prefix}-OsDisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Premium_LRS"
  }

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04.0-LTS"
    version   = "latest"
  }

  os_profile {
    computer_name  = "${var.prefix}-TFVM"
    admin_username = var.admin_username
    admin_password = var.admin_password
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }
}
# create a windows vm
resource "azurerm_windows_virtual_machine" "new_wvm" {
  name                = "example-machine"
  resource_group_name = azurerm_resource_group.new_rg.name
  location            = azurerm_resource_group.new_rg.location
  size                = "Standard_F2"
  admin_username      = var.admin_username
  admin_password      = var.admin_password
  network_interface_ids = [
    azurerm_network_interface.new_nic.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }
}

// data "azurerm_public_ip" "new_ip" {
//   name                = azurerm_public_ip.new_publicip.name
//   resource_group_name = azurerm_virtual_machine.new_vm.resource_group_name
//   depends_on          = [azurerm_virtual_machine.new_vm]
// }
module "azure-bastion" {
  source = "kumarvna/azure-bastion/azurerm"
  #   depends_on = [azurerm_virtual_network.vnet, azurerm_resource_group.rg]
  version = "1.0.0"

  # Resource Group, location, VNet and Subnet details
  resource_group_name  = azurerm_resource_group.new_rg.name
  virtual_network_name = azurerm_virtual_network.new_vnet.name

  # Azure bastion server requireemnts
  azure_bastion_service_name          = "${var.prefix}-Bastion-Service"
  azure_bastion_subnet_address_prefix = ["10.42.2.0/26"]

  # Adding TAG's to your Azure resources (Required)
  tags = {
    ProjectName  = "demo-internal"
    Env          = "dev"
    Owner        = "user@example.com"
    BusinessUnit = "CORP"
    ServiceClass = "Gold"
  }
}
