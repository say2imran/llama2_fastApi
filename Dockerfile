# Use official Python image as base
FROM python:3.10

# Install build tools and required libraries
RUN apt-get update && apt-get install -y \
    git cmake build-essential curl ninja-build \
    python3-dev libopenblas-dev liblapack-dev \
    pkg-config gfortran libffi-dev ca-certificates libc6-dev \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Copy source code and model
COPY ./app.py ./app.py
COPY ./models ./models

# Upgrade pip and install Python dependencies
RUN pip install --upgrade pip
RUN pip install fastapi uvicorn pydantic

# Set environment variables for CPU-only build
ENV CMAKE_ARGS="-DLLAMA_METAL=off -DLLAMA_AVX2=off -DLLAMA_FMA=off"
ENV FORCE_CMAKE=1

# Install llama-cpp-python with verbose output and version pinning
RUN pip install -v llama-cpp-python==0.2.24

EXPOSE 8000

CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000"]
