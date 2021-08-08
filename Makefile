IMAGE_VERSION=0.1.0
PASSWORD="super secret"

build:
	docker build -t ckemper/neovim:${IMAGE_VERSION} .

run:
	docker run \
	-v `pwd`:/work \
  -it ckemper/neovim:${IMAGE_VERSION}

run-sh:
	docker run \
	-v `pwd`:/work \
	--entrypoint=ash \
  -it ckemper/neovim:${IMAGE_VERSION}

login:
	docker login -u ckemper -p ${PASSWORD}

publish:
	docker push \
		ckemper/neovim:${IMAGE_VERSION}

publish-latest:
	docker tag \
		ckemper/neovim:${IMAGE_VERSION} \
		ckemper/neovim:latest
	docker push \
		ckemper/neovim:latest
