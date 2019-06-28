.PHONY : clearscr fresh clean all

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

