FROM python:3.14.4-slim

RUN apt update && apt upgrade -y && apt install -y build-essential libpq-dev

WORKDIR /app

COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

COPY . .

CMD ["python", "app.py"]