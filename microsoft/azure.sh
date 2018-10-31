# Install azure-cli
curl -L https://aka.ms/InstallAzureCli | bash

# Re-sourcing our bashrc
exec -l $SHELL

# Login
az login

# Create a resource group
az group create --name pdf2image-demo-resource --location eastus

# Create an Azure container registry
az acr create --resource-group pdf2image-demo-resource --name pdf2image-demo --sku Basic

# Log in Azure container registry
az acr login --name pdf2image-demo

# Build docker container
docker build ../app -t pdf2image-demo

# Tag the image in the azure image registry
TAG=$(az acr show --name pdf2image-demo --query loginServer)

# Tag docker image
docker tag pdf2image-demo $TAG/pdf2image-demo:v1

# Push the image to the registry
docker push $TAG/pdf2image-demo:v1

# Enable admin permission on the registry to deploy
az acr update -n pdf2image-demo --admin-enabled true

# Get password for deployment
SECRET=$(az acr credential show --name pdf2image-demo --query "passwords[0].value")

echo "Your password is: "
echo $SECRET

az container create --resource-group pdf2image-demo-resource --name pdf2image-demo --image $TAG/pdf2image-demo:v1 --cpu 1 --memory 1 --ip-address public --ports 80 --registry-password "$SECRET"

