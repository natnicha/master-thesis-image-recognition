
from fastapi import APIRouter, status

from app.api.ml.model import ClassifyResponseModel

ml = APIRouter()

@ml.get("/classify", response_model=ClassifyResponseModel, status_code=status.HTTP_200_OK)
async def classify():
    return ClassifyResponseModel(name="Hello World")
