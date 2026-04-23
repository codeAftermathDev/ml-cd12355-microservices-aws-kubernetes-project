# Parameterize values for private ECR base image
# Example build command:
#   docker build \
#       --build-arg AWS_ACCOUNT_ID=123456789012 \
#       --build-arg AWS_REGION=us-east-1 \
#       -t app .
ARG AWS_ACCOUNT_ID
ARG AWS_REGION
FROM ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/base-images/python:3.14.4-slim
#FROM python:3.14.4-slim # Using a base image from private ECR to avoid hitting Docker Hub rate limits

RUN apt update && apt upgrade -y && apt install -y build-essential libpq-dev

WORKDIR /app

COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

COPY . .

CMD ["python", "app.py"]