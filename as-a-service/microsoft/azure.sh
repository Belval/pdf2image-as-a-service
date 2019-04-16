# Piping to to bash is always a bad idea. Feel free
# to install the Azure CLI SDK yourself and comment that line.
#curl -L https://aka.ms/InstallAzureCli | bash

# Login
az login

# Creating the resource group
az group create --name pdf2imageDemoGroup --location eastus

# Creating the container registry
az acr create --resource-group pdf2imageDemoGroup --name pdf2imageDemo --sku Basic

# Log into the container registry
az acr login --name pdf2imageDemo

# Build docker image
docker build ../app -t pdf2image-demo-app

# Tag image in Azure image registry
TAG=$(az acr show --name pdf2imageDemo --query loginServer)
TAG=${TAG//\"}

# Tag the docker image
docker tag pdf2image-demo-app $TAG/pdf2image-demo-app:v1

# Push the docker image to the registry
docker push $TAG/pdf2image-demo-app:v1

# Enable administrative rights
az acr update -n pdf2imageDemo --admin-enabled true

# Get the deployment password
PASSWORD=$(az acr credential show --name pdf2imageDemo --query "passwords[0].value")
PASSWORD=${PASSWORD//\"}

# Finally, deploy the docker container
# When prompted, enter pdf2imageDemo
az container create --resource-group pdf2imageDemoGroup --name pdf2image-demo-app --image $TAG/pdf2image-demo-app:v1 --cpu 1 --memory 1 --ip-address public --ports 5000 --registry-password "$PASSWORD"


# Get the IP address of the container
az container show --resource-group pdf2imageDemoGroup --name pdf2image-demo-app --query ipAddress.ip



