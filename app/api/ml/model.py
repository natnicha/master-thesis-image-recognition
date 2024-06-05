from pydantic import BaseModel

class ClassifyResponseModel(BaseModel):
    name: str
