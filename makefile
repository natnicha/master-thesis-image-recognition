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

# Please note that these settings apply when deploying in swarm mode. To apply these limits when using docker-compose up, you need to add the --compatibility flag to your command:
docker-compose-up-with-limits:
	docker-compose --compatibility up

prometheus-run:
	docker run -d -p 9090:9090 -v .\prometheus.yml:/etc/prometheus/prometheus.yml prom/prometheus

swarm-manager-init:
	docker swarm init

service-create:
	docker service create --name ml --replicas=3 master-thesis-image-recognition-app

service-list:
	docker service ls
	
to get the average CPU usage percentage over 5 minutes
avg(rate(process_cpu_seconds_total{job="your_job"}[5m])) * 100

And for memory usage percentage:
avg(process_resident_memory_bytes{job="your_job"}) / avg(node_memory_Active_bytes{job="your_job"}) * 100