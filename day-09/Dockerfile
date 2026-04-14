FROM python:3.9-slim

# 1. Create a non-root system user (no password, with home directory)
RUN useradd -m myuser

# 2. Set the working directory
WORKDIR /app

# 3. Copy application files
COPY . .

# 4. Change ownership of the app folder to our new user
RUN chown -R myuser:myuser /app

# 5. Switch to the non-root user (SECURITY: No longer running as root)
USER myuser

# 6. Run the application
CMD ["python", "app.py"]