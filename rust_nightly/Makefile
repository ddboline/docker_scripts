version := "0.0.3"
release := "1"
build_type := release

all:
	cp Dockerfile.bionic Dockerfile
	docker build --no-cache -t rust_nightly:${version} .
	docker tag rust_nightly:${version} rust_nightly:latest

cleanup:
	docker rmi `docker images | python -c "import sys; print('\n'.join(l.split()[2] for l in sys.stdin if '<none>' in l))"`

push:
	`aws ecr get-login --no-include-email`
	docker tag rust_nightly:latest 281914939654.dkr.ecr.us-east-1.amazonaws.com/rust_nightly:latest
	docker push 281914939654.dkr.ecr.us-east-1.amazonaws.com/rust_nightly:latest
	docker rmi 281914939654.dkr.ecr.us-east-1.amazonaws.com/rust_nightly:latest

pull:
	`aws ecr get-login --no-include-email`
	docker pull 281914939654.dkr.ecr.us-east-1.amazonaws.com/rust_nightly:latest
	docker tag 281914939654.dkr.ecr.us-east-1.amazonaws.com/rust_nightly:latest rust_nightly:latest
	docker rmi 281914939654.dkr.ecr.us-east-1.amazonaws.com/rust_nightly:latest
