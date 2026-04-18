FROM python:3.9-slim

WORKDIR /app

# Accept build-time version argument (passed from GitHub Actions)
ARG APP_VERSION=local
ENV APP_VERSION=${APP_VERSION}

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

EXPOSE 5000

CMD ["python", "app.py"]