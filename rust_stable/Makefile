version := "0.1.0"
release := "1"
build_type := release
ubuntu_release := jammy
aws_release := $(shell aws sts get-caller-identity | awk '/Account/ {print $2}' | sed 's:[^0-9]::g')

all:
	docker build --compress -t rust_stable:${version} -f Dockerfile.${ubuntu_release} .
	docker tag rust_stable:${version} rust_stable:latest

cleanup:
	docker rmi `docker images | python -c "import sys; print('\n'.join(l.split()[2] for l in sys.stdin if '<none>' in l))"`
	docker system prune -f

push:
	`aws ecr --region us-east-1 get-login --no-include-email`
	docker tag rust_stable:latest ${aws_release}.dkr.ecr.us-east-1.amazonaws.com/rust_stable:latest
	docker push ${aws_release}.dkr.ecr.us-east-1.amazonaws.com/rust_stable:latest
	docker rmi ${aws_release}.dkr.ecr.us-east-1.amazonaws.com/rust_stable:latest

pull:
	`aws ecr --region us-east-1 get-login --no-include-email`
	docker pull ${aws_release}.dkr.ecr.us-east-1.amazonaws.com/rust_stable:latest
	docker tag ${aws_release}.dkr.ecr.us-east-1.amazonaws.com/rust_stable:latest rust_stable:latest
	docker rmi ${aws_release}.dkr.ecr.us-east-1.amazonaws.com/rust_stable:latest

alpine:
	docker build --compress -t rust_stable:alpine-${version} -f Dockerfile.alpine .
	docker tag rust_stable:alpine-${version} rust_stable:alpine-latest

push-alpine:
	`aws ecr --region us-east-1 get-login --no-include-email`
	docker tag rust_stable:alpine-latest ${aws_release}.dkr.ecr.us-east-1.amazonaws.com/rust_stable:alpine-latest
	docker push ${aws_release}.dkr.ecr.us-east-1.amazonaws.com/rust_stable:alpine-latest
	docker rmi ${aws_release}.dkr.ecr.us-east-1.amazonaws.com/rust_stable:alpine-latest

pull-alpine:
	`aws ecr --region us-east-1 get-login --no-include-email`
	docker pull ${aws_release}.dkr.ecr.us-east-1.amazonaws.com/rust_stable:alpine-latest
	docker tag ${aws_release}.dkr.ecr.us-east-1.amazonaws.com/rust_stable:alpine-latest rust_stable:alpine-latest
	docker rmi ${aws_release}.dkr.ecr.us-east-1.amazonaws.com/rust_stable:alpine-latest
