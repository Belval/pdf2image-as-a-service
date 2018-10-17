FROM python:3.5
ADD . /app
WORKDIR /app
RUN pip install -r requirements.txt
RUN apt-get update && apt-get install -y
RUN apt-get install poppler-utils -y
EXPOSE 5000
CMD ["python", "app.py"]
