# pdf2image-as-a-service
Deploying a basic application on Google Cloud, AWS and Azure using docker

## What is this?

This is a completely fictional project that I made called "pdf2image-as-a-service" what it does is convert a pdf sent through HTTP into jpegs with a small flask web app.

The interesting piece is not how such thing works, but how it can be deployed on the three most significant cloud providers, namely Google, Amazon and Microsoft.

Here's what each script does:

- `app.py`: The application
- `amazon-web-service.sh`: Deploy to AWS
- `azure.sh`: Deploy to Azure
- `google-cloud.sh`: Deploy to Google Cloud

## Why is this interesting?

It shows the differences between all three providers