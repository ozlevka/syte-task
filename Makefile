build-server:
	#Run build server
	packer build ./packer/build-server.json
build-lb:
	# Run build load balancer
	packer build ./packer/build-lb.json

build: build-server build-lb
	# build all containers

run:
	# run docker swarm for demonstrate architecture
	./swarm/run-swarm.sh

stop:
	# Stop running swarm
	docker swarm leave -f

upload:
	# Upload containers (not packer) because you should be logged in.
	docker push ozlevka/syte-lb:0.0.1 && docker push ozlevka/syte-server:0.0.1

tfapply:
	cd terraform && \
	terraform plan -out=tfplan && \
	terraform apply tfplan

tfdestroy:
	cd terraform && \
	terraform destroy