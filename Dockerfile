FROM python:3.9-alpine

WORKDIR /app
COPY ./src ./src
COPY requirements.txt requirements.txt
COPY main.py main.py

RUN pip install -r requirements.txt
EXPOSE 3000

CMD ["python", "uvicorn", "main:app"]
