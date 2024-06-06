from fastapi import FastAPI
from prometheus_fastapi_instrumentator import Instrumentator
from app.api.ml.ml import ml

app = FastAPI()

app.include_router(ml, prefix='/api/v1/ml', tags=['ml'])

@app.get("/")
async def root():
    return {"message": "Hello World"}

instrumentator = Instrumentator().instrument(app)

@app.on_event("startup")
async def startup():
    instrumentator.expose(app)
