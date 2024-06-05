from fastapi import APIRouter, status
from torchvision.io import read_image
from torchvision.models import efficientnet_b3, EfficientNet_B3_Weights

from app.api.ml.model import ClassifyResponseModel

ml = APIRouter()

@ml.get("/classify", response_model=ClassifyResponseModel, status_code=status.HTTP_200_OK)
async def classify():
    img = read_image("./dataset/acinonyx-jubatus/acinonyx-jubatus_0_052c1ab2.jpg")

    # Step 1: Initialize model with the best available weights
    weights = EfficientNet_B3_Weights.DEFAULT
    model = efficientnet_b3(weights=weights)
    model.eval()

    # Step 2: Initialize the inference transforms
    preprocess = weights.transforms()

    # Step 3: Apply inference preprocessing transforms
    batch = preprocess(img).unsqueeze(0)

    # Step 4: Use the model and print the predicted category
    prediction = model(batch).squeeze(0).softmax(0)
    class_id = prediction.argmax().item()
    score = prediction[class_id].item()
    category_name = weights.meta["categories"][class_id]

    return ClassifyResponseModel(name=category_name, score=f"{100*score:.1f}")
