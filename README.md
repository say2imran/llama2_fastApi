# Llama 2 FastAPI

This project provides a FastAPI server for text generation using the Llama 2 model via the `llama-cpp-python` library.

## Features
- REST API for text generation
- Runs Llama 2 model locally (CPU-only, Dockerized)

## Requirements
- Docker
- Sufficient RAM and disk space for the Llama 2 model (7B model is ~4GB)

## Getting Started

### 1. Download the Llama 2 Model

You need to download the Llama 2 model weights from HuggingFace. You must have a HuggingFace account and accept the model license.

1. Go to the [Llama 2 7B Chat GGUF page on HuggingFace](https://huggingface.co/TheBloke/Llama-2-7B-Chat-GGUF)
2. Download the file named `llama-2-7b-chat.Q4_K_M.gguf` (or adjust the filename in `app.py` if you use a different quantization)
3. Place the downloaded file in a `models` directory at the root of this project:

```
llama2_fastApi/
  app.py
  Dockerfile
  requirements.txt
  models/
    llama-2-7b-chat.Q4_K_M.gguf
```

### 2. Build the Docker Image

```
docker build -t llama2-fastapi .
```

### 3. Run the API Server

```
docker run -p 8000:8000 llama2-fastapi
```

### 4. Test the API

- Health check:
  - `GET http://localhost:8000/` → `{ "message": "Hello! API is running." }`
- Generate text:
  - `POST http://localhost:8000/generate`
  - JSON body:
    ```json
    {
      "prompt": "Once upon a time,",
      "max_tokens": 100
    }
    ```

## Notes
- The first request may be slow as the model loads into memory.
- Adjust `max_tokens` and model path as needed in `app.py`.
- For other Llama 2 variants, download the appropriate GGUF file and update the path in `app.py`.

## License
This project is for research and personal use. Please respect the Llama 2 model license from Meta and HuggingFace. 