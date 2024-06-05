FROM bitnami/pytorch

WORKDIR /app
COPY ./app ./app
COPY requirements.txt requirements.txt
COPY main.py main.py

RUN pip install -r requirements.txt
EXPOSE 8000
USER root

CMD ["fastapi", "run", "main.py", "--proxy-headers", "--host", "localhost", "--port", "8000"]
