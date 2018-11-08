# pdf2image-as-a-service
Deploying a basic application on Google Cloud, AWS and Azure using docker

## What is this?

This is a completely fictional project that I made called "pdf2image-as-a-service" what it does is convert a pdf sent through HTTP into jpegs with a small flask web app.

The interesting piece is not how such thing works, but how it can be deployed on the three most significant cloud providers, namely Google, Amazon and Microsoft.

Here's what each script does:

- `app.py`: The application
- `microsoft/azure.sh`: Deploy to Azure
- `google/google_cloud.sh`: Deploy to Google Cloud
- `amazon/aws.sh`: Deploy to AWS (Coming soon!)

## Valuable information

- The user that will be used to run this script must be part of the docker group other wise it will not work.
- When deployed on Google Cloud, the app is on port 80. When deployed to Azure it is on port 5000 because they do not offer forwarding.

## Why is this interesting?

It shows the differences between all three providers

## My personal opinion regarding the providers

Disclaimer: My experience with these services is shallow and the opinions you can read here are not to be taken as absolute. 

As of 2018, and after deploying on Google Cloud, Microsoft Azure, Amazon AWS:

- For all three I resorted to third party tutorials instead of the official documentation because I found it be lacking.
- Azure as, by far, the best web interface. It is clean, easy to use and there is a feeling of overall cohesion.
- Using Kubernetes on Google Cloud felt more natural than on the other two.
- Azure does not offer port forwarding. For example, I am serving my application on port 5000 on the container, but the instance cannot forward its traffic from 80 to 5000 easily. This is available with Google Cloud.