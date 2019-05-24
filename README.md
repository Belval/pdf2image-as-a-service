# pdf2image-as-a-service
Deploying a basic application on Google Cloud, AWS and Azure using docker

## What is this?

This is a completely fictional project that I made called "pdf2image-as-a-service" what it does is convert a pdf sent through HTTP into jpegs with a small flask web app.

The interesting piece is not how such thing works, but how it can be deployed on the three most significant cloud providers, namely Google, Amazon and Microsoft.

The project contains two projects `as-a-service` and `as-a-function`. The first one is about deploying the above as a container, while the second is about deploying as a function.

Here's what each file in `as-a-service` does:

- `app/app.py`: The application
- `microsoft/azure.sh`: Deploy to Azure
- `google/google_cloud.sh`: Deploy to Google Cloud
- `amazon/aws.sh`: Deploy to AWS (Coming soon!)

Now for `as-a-function`:

- `build_poppler.sh`: Script to build poppler executable used by pdf2image
- `microsoft/function.sh`: Deploy as a function to azure
- `google/app_engine.sh`: Deploy as a function to GCP
- `amazon/lambda.sh`: Deploy as a function on AWS

At the current time, only AWS Lambda works. You can run it with these steps:

1. `cd as-a-function`
2. `bash -c amazon/lambda.sh`

The `output.json` is a dictionary containing the resulting images as base64.

## Valuable information

- The user that will be used to run this script must be part of the docker group otherwise it will not work.
    - `sudo usermod -aG docker $USER`
- When deployed on Google Cloud, the app is on port 80. When deployed to Azure it is on port 5000 because they do not offer port forwarding.

## My personal opinion regarding the providers

Disclaimer: My experience with these services is shallow and the opinions you can read here are not to be taken as absolute.

As of 2018, and after deploying on Google Cloud, Microsoft Azure, Amazon AWS:

- For all three, I resorted to third party tutorials instead of the official documentation.
- Azure is, by far, the best web interface. It is clean, easy to use and there is a feeling of overall cohesion.
- Using Kubernetes on Google Cloud felt more natural than on the other two.
- Azure does not offer port forwarding. For example, I am serving my application on port 5000 on the container, but the instance cannot forward its traffic from 80 to 5000 easily. This is available with Google Cloud.
- Amazon documentation feels very scarce and the UI to read it is unintuitive.
- Amazon seems to aim for configuration using their UI with little "good" tutorials on how to use the aws cli tool.
