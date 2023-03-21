IMAGE := us.gcr.io/kapwing-dev/FullSubNet-plus
TAG := latest

build:
	DOCKER_BUILDKIT=1 docker build -f Dockerfile -t {IMAGE} .

push:
	docker tag $(IMAGE) $(IMAGE):$(TAG)
	docker push $(IMAGE):$(TAG)