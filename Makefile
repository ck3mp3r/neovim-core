IMAGE_VERSION=snapshot
PASSWORD="super secret"

build:
	docker build -t ckemper/neovim-core:${IMAGE_VERSION} .

run:
	docker run \
	-v `pwd`:/work \
  -it --rm ckemper/neovim-core:${IMAGE_VERSION}

sh:
	docker run \
	-v `pwd`:/work \
	--entrypoint=ash \
  -it --rm ckemper/neovim-core:${IMAGE_VERSION}

login:
	docker login -u ckemper -p ${PASSWORD}

publish:
	docker push \
		ckemper/neovim-core:${IMAGE_VERSION}

publish-latest:
	docker tag \
		ckemper/neovim-core:${IMAGE_VERSION} \
		ckemper/neovim-core:latest
	docker push \
		ckemper/neovim-core:latest
