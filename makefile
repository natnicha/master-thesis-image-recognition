shell:
	pipenv shell

run:
	python -m uvicorn main:app --reload

gen-req:
	pipenv requirements > requirements.txt

gen-req-freeze-ver:
	pip3 freeze requirements > requirements.txt

docker-build:
	docker build -t ml .

docker-run:
	docker run -p 8000:3000 ml

docker-compose-up:
	docker-compose up

prometheus-run:
	docker run -d -p 9090:9090 -v .\prometheus.yml:/etc/prometheus/prometheus.yml prom/prometheus

swarm-manager-init:
	docker swarm init

service-create:
	docker service create --name ml --replicas=3 master-thesis-image-recognition-app

service-list:
	docker service ls
