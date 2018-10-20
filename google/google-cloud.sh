# Create environment variable for correct distribution
export CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)"

# Add the Cloud SDK distribution URI as a package source
echo "deb http://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list

# Import the Google Cloud Platform public key
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -

# Update the package list and install the Cloud SDK
sudo apt-get update -yq
sudo apt-get install google-cloud-sdk -yq
# Installing kukectl
sudo apt-get install kubectl

# Obviously we have to login first
gcloud auth login

echo "Please enter your project ID"
read project

# Config our gcloud to use our project
gcloud config set project ${project}

# Building the docker image
sudo docker build -t gcr.io/${project}/pdf2image-demo:v1 ../app

# Configuring Google Cloud
gcloud auth configure-docker

# Setting compute zone
gcloud config set compute/zone us-central1-b

# Pushing our image to Google Cloud
sudo docker push gcr.io/${project}/pdf2image-demo:v1

# Creating a cluster (of one because we aren't made of money!)
gcloud container clusters create pdf2image-demo-cluster --num-nodes=1

# Deploy our app
kubectl run pdf2image-demo-cluster --image=gcr.io/${project}/pdf2image-demo:v1 --port 5000

# Finally, exposing our application to the cold wide web!
kubectl expose deployment pdf2image-demo-cluster --type=LoadBalancer --port 80 --target-port 5000

# And, lets display the given IP for easy testing!
kubectl get service