# pdf2image-as-a-service
Deploying a basic application on GAE, AWS and Azure

## What is this?

This is a completely fictional project that I made called "pdf2image-as-a-service" what it does is convert a pdf sent through HTTP into jpegs with a small flask web app.

The interesting piece is not how such thing works, but how it can be deployed on the three most significant cloud providers, namely Google, Amazon and Microsoft.

Here's what you will find in each folder:

- `pdf2image-as-a-service` contains our web app.
- `google-application-engine` contains (almost) everything you need to deploy it on Google Application Engine (flexible)
- `amazon-web-service-lambda` contains (almost) everything you need to deploy it on AWS Lambda
- `microsoft-azure-functions` contains (almost) everything you need to deploy it on Microsoft Azure Functions

This is meant mostly as a bare-bone tutorial for curious people with no experience with these services.

## Why is this interesting?

Most example I found were simple "Look now the page says Hello world!" that's very nice but it provide little relevance on how file I/O work, what I can and cannot do, etc...