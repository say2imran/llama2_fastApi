from fastapi import FastAPI
from pydantic import BaseModel
from llama_cpp import Llama

# Use CPU backend (Metal not available in Docker)
llm = Llama(model_path="./models/llama-2-7b-chat.Q4_K_M.gguf", n_ctx=512)

app = FastAPI()

class PromptRequest(BaseModel):
    prompt: str
    max_tokens: int = 100

@app.get("/")
def root():
    return {"message": "Hello! API is running."}
    
@app.post("/generate")
def generate(req: PromptRequest):
    result = llm(req.prompt, max_tokens=req.max_tokens)
    return {"response": result["choices"][0]["text"].strip()}
