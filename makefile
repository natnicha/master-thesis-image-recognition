shell:
	pipenv shell

run:
	python -m uvicorn main:app --reload

gen-req:
	pipenv requirements > requirements.txt

docker-build:
	docker build -t ml .

docker-run:
	docker run -p 8000:3000 ml

docker-compose-up:
	docker-compose up
