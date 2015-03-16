image?=maxcdn/bootstrapcdn
tag?=latest
name?=bootstrapcdn
NODE_ENV?=production
PORT?=3000

build:
	docker build -t $(image):$(tag)
	cd _nginx; docker build -t $(image)-nginx:$(tag)

start:
	docker run -d -e PORT=$(PORT) -e NODE_ENV=$(NODE_ENV) \
		--name=$(name)01 $(image)
	docker run -d -e PORT=$(PORT) -e NODE_ENV=$(NODE_ENV) \
		--name=$(name)02 $(image)
	docker run -d -e PORT=$(PORT) -e NODE_ENV=$(NODE_ENV) \
		--name=$(name)03 $(image)

stop:
	docker stop --time=10 $(name)01 $(name)02 $(name)03 $(name)-nginx

rm:
	docker rm -f $(name)01 $(name)02 $(name)03 $(name)-nginx


restart:
	# Rolling restart.
	# ###
	# Remove 01
	docker stop --time=10 $(name)01
	docker rm -f $(name)01
	# Start 01
	docker run -d -e PORT=$(PORT) -e NODE_ENV=$(NODE_ENV) \
		--name=$(name)01 $(image)
	# Remove 02 and 03
	docker stop --time=10 $(name)02 $(name)03 $(name)-nginx
	docker rm -f $(name)02 $(name)03 $(name)-nginx
	# Start 02 and 03
	docker run -d -e PORT=$(PORT) -e NODE_ENV=$(NODE_ENV) \
		--name=$(name)02 $(image)
	docker run -d -e PORT=$(PORT) -e NODE_ENV=$(NODE_ENV) \
		--name=$(name)03 $(image)
