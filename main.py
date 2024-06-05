from fastapi import FastAPI
from app.api.ml.ml import ml

app = FastAPI()

app.include_router(ml, prefix='/api/v1/ml', tags=['ml'])

@app.get("/")
async def root():
    return {"message": "Hello World"}
