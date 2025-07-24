# ----------- Build Stage -------------
FROM python:3.11-slim as builder

WORKDIR /app

# Install build dependencies
RUN apt-get update && apt-get install -y build-essential

# Copy and install dependencies
COPY requirements.txt .
RUN pip install --upgrade pip
RUN pip install --prefix=/install -r requirements.txt

# ----------- Runtime Stage -------------
FROM python:3.11-slim

WORKDIR /app

# Copy only installed packages from build stage
COPY --from=builder /install /usr/local

# Copy app source
COPY app.py .

# Expose port
EXPOSE 5000

# Run the application
CMD ["python", "app.py"]
