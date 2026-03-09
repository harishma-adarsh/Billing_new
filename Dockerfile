# Use an official Python runtime as a parent image
FROM python:3.11-slim

# Install system dependencies for xhtml2pdf (pycairo needs cairo dev libs)
RUN apt-get update && apt-get install -y \
    python3-pip \
    python3-cffi \
    pkg-config \
    libcairo2-dev \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Set the working directory in the container
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Install any needed packages specified in requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Make port 80 available to the world outside this container
EXPOSE 80

# Run gunicorn
CMD ["gunicorn", "--bind", "0.0.0.0:80", "app:app"]
