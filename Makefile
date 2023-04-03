# IMAGE := us.gcr.io/kapwing-dev/scripts/fullsubnet
IMAGE = fullsubnet
TAG := latest

build:
	DOCKER_BUILDKIT=1 docker build -f Dockerfile -t $(IMAGE) .

push:
	docker tag $(IMAGE) $(IMAGE):$(TAG)
	docker push $(IMAGE):$(TAG)

run:
	docker run $(IMAGE) -C "./config/inference.toml" -M "./best_model.tar" -I "./input_files" -O "./output_files"

create_env_file: conda list -n speech_enhance --explicit spec-file.txt