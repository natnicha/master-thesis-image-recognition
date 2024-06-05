shell:
	pipenv shell

run:
	python -m uvicorn main:app --reload

gen-req:
	pipenv requirements > requirements.txt

docker-build:
	docker build -t ml .

docker-run:
	docker run ml

docker-compose-up:
	docker-compose up
