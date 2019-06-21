version := "0.0.3"
release := "1"
build_type := release

all:
	cp Dockerfile.bionic Dockerfile
	docker build -t rust_stable:${version} .
	docker tag rust_stable:${version} rust_stable:latest

xenial:
	cp Dockerfile.xenial Dockerfile
	docker build -t rust_stable:xenial_${version} .
	docker tag rust_stable:xenial_${version} rust_stable:xenial_latest

cleanup:
	docker rmi `docker images | python -c "import sys; print('\n'.join(l.split()[2] for l in sys.stdin if '<none>' in l))"`

push:
	`aws ecr get-login --no-include-email`
	docker tag rust_stable:latest 281914939654.dkr.ecr.us-east-1.amazonaws.com/rust_stable:latest
	docker push 281914939654.dkr.ecr.us-east-1.amazonaws.com/rust_stable:latest
	docker rmi 281914939654.dkr.ecr.us-east-1.amazonaws.com/rust_stable:latest

push_xenial:
	`aws ecr get-login --no-include-email`
	docker tag rust_stable:xenial_latest 281914939654.dkr.ecr.us-east-1.amazonaws.com/rust_stable:xenial_latest
	docker push 281914939654.dkr.ecr.us-east-1.amazonaws.com/rust_stable:xenial_latest
	docker rmi 281914939654.dkr.ecr.us-east-1.amazonaws.com/rust_stable:xenial_latest

pull:
	`aws ecr get-login --no-include-email`
	docker pull 281914939654.dkr.ecr.us-east-1.amazonaws.com/rust_stable:latest
	docker tag 281914939654.dkr.ecr.us-east-1.amazonaws.com/rust_stable:latest rust_stable:latest
	docker rmi 281914939654.dkr.ecr.us-east-1.amazonaws.com/rust_stable:latest

pull_xenial:
	`aws ecr get-login --no-include-email`
	docker pull 281914939654.dkr.ecr.us-east-1.amazonaws.com/rust_stable:xenial_latest
	docker tag 281914939654.dkr.ecr.us-east-1.amazonaws.com/rust_stable:xenial_latest rust_stable:xenial_latest
	docker rmi 281914939654.dkr.ecr.us-east-1.amazonaws.com/rust_stable:xenial_latest
