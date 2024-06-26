import io
import logging
from fastapi import APIRouter, File, HTTPException, Query, UploadFile, status
from torch import Tensor
from PIL import Image
import torchvision.transforms as transforms 
from torchvision.io import read_image
from torchvision.models import efficientnet_b3, EfficientNet_B3_Weights

from app.api.ml.model import *

ml = APIRouter()

@ml.post("/classify", response_model=ClassifyResponseModel, status_code=status.HTTP_200_OK)
async def classify(
        file: UploadFile = File(...)):
    
    try:
        image_bytes = file.file.read()
        image = Image.open(io.BytesIO(image_bytes))
        transform = transforms.Compose([ 
            transforms.ToTensor(),
            transforms.Normalize(mean=[0.485, 0.456, 0.406], std=[0.229, 0.224, 0.225])
        ]) 
        img_tensor = transform(image) 
    except Exception as e:
        logging.error(msg=str(e))
        raise HTTPException(
            detail={"message": str(e)},
            status_code=status.HTTP_400_BAD_REQUEST
        )
    finally:
        file.file.close()
    
    try:
        category_name, score = predict(image=img_tensor)
    except Exception as e:
        raise HTTPException(
            detail={"message": str(e)},
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR
        )
    return ClassifyResponseModel(name=category_name, score=f"{100*score:.1f}")

def predict(image: Tensor):
    # Step 1: Initialize model with the best available weights
    weights = EfficientNet_B3_Weights.DEFAULT
    model = efficientnet_b3(weights=weights)
    model.eval()

    # Step 2: Initialize the inference transforms
    preprocess = weights.transforms()

    # Step 3: Apply inference preprocessing transforms
    batch = preprocess(image).unsqueeze(0)

    # Step 4: Use the model and print the predicted category
    prediction = model(batch).squeeze(0).softmax(0)
    class_id = prediction.argmax().item()
    score = prediction[class_id].item()
    category_name = weights.meta["categories"][class_id]
    return category_name, score
