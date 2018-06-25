TAG := "latest"
# DIR points to the directory with the Dockerfile to be built:
DIR ?= $(addprefix $(PWD), /x86-alpine)
DOCKER_REPO ?= gmusicapi-scripts-$(shell basename $(DIR))
IMAGE_NAME ?= $(DOCKER_REPO):$(TAG)

default: build

build:
	# if DIR contains 'arm', initialize cross platform hack
ifneq (,$(findstring arm,$(DIR)))
	# Found
	docker run --rm --privileged multiarch/qemu-user-static:register --reset
endif
	docker build -t $(IMAGE_NAME) -f $(DIR)/Dockerfile .
	docker tag $(IMAGE_NAME) $(DOCKER_REPO):latest

push:
	docker push $(IMAGE_NAME)
	docker push $(DOCKER_REPO)

test:
	docker run --rm $(IMAGE_NAME) /bin/echo "Success."
	docker run --rm $(IMAGE_NAME) /usr/local/bin/gmsync --help

rmi:
	docker rmi -f $(IMAGE_NAME)

post_checkout:
	docker run --rm --privileged multiarch/qemu-user-static:register --reset

post_push:
	docker tag $(IMAGE_NAME) $(DOCKER_REPO):$(TAG)
	docker push $(DOCKER_REPO):$(TAG)

rebuild: rmi build
