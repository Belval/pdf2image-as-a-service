#
# function.sh
#

# Piping to to bash is always a bad idea. Feel free
# to install the Azure CLI SDK yourself and comment that line.
#curl -sL https://aka.ms/InstallAzureCli | sudo bash

# Install core tools
#sudo npm install -g azure-functions-core-tools

# Create function app
storageName=p2idemostorage$RANDOM
functionAppName=pdf2imagedemo$RANDOM

# Create a resource group.
az group create --name pdf2image_demo_resource_group --location westeurope

# Create an Azure storage account in the resource group.
az storage account create \
  --name $storageName \
  --location westeurope \
  --resource-group pdf2image_demo_resource_group \
  --sku Standard_LRS

# Create a serverless function app in the resource group.
az functionapp create \
  --name $functionAppName \
  --storage-account $storageName \
  --consumption-plan-location westeurope \
  --resource-group pdf2image_demo_resource_group \
  --runtime python \
  --os-type Linux

sleep 5

# Publish function app
func azure functionapp publish $functionAppName

# Delete resource group once we're done
#az group delete --name pdf2image_demo_resource_group

