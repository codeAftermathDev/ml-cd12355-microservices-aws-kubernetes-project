# Pointing to a private ecr to get base image. Hitting the rate limit 
#too soon when fetching base image.
#
# Example build command:
#   docker build \
#       --build-arg AWS_ACCOUNT_ID=123456789012 \
#       --build-arg AWS_REGION=us-east-1 \
#       -t app .

#FROM python:3.14.4-slim

ARG AWS_ACCOUNT_ID
ARG AWS_REGION=us-east-1
FROM ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/base-images/python:3.14.4-slim
# FROM --platform=linux/arm64 ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/base-images/python:3.14.4-slim-arm64

RUN apt update && apt upgrade -y && apt install -y build-essential libpq-dev

WORKDIR /app

COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

COPY . .

CMD ["python", "app.py"]