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

service-update-port:
	docker service update --publish-add 8000:3000 machine-learning

service-scale:
	docker service scale ml=1

service-list:
	docker service ls

create-cadvisor-monitoring:
	docker service create --name cadvisor -l prometheus-job=cadvisor --mode=global --publish target=8000,mode=host --mount type=bind,src=/var/run/docker.sock,dst=/var/run/docker.sock,ro --mount type=bind,src=/,dst=/rootfs,ro --mount type=bind,src=/var/run,dst=/var/run --mount type=bind,src=/sys,dst=/sys,ro --mount type=bind,src=/var/lib/docker,dst=/var/lib/docker,ro google/cadvisor -docker_only 
	

query-emory-usage:
	container_memory_usage_bytes{container_label_com_docker_swarm_service_name="machine-learning"}/(1024*1024)


query-cpu-usage:
	sum(rate(container_cpu_usage_seconds_total{container_label_com_docker_swarm_service_name="machine-learning"}[1m]))*100

query-cpu-usage-percentage:
	sum(rate(container_cpu_usage_seconds_total{container_label_com_docker_swarm_service_name="machine-learning"}[1m])) / sum(machine_cpu_cores) *100
