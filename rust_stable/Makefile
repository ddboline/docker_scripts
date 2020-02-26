version := "0.1.0"
release := "1"
build_type := release
aws_release := $(shell aws sts get-caller-identity | awk '/Account/ {print $2}' | sed 's:[^0-9]::g')

all:
	cp Dockerfile.bionic Dockerfile
	docker build --no-cache -t rust_stable:${version} .
	docker tag rust_stable:${version} rust_stable:latest

amazon:
	cp Dockerfile.amazon Dockerfile
	docker build --no-cache -t rust_stable:${version} .
	docker tag rust_stable:${version} rust_stable:latest_amazon

cleanup:
	rm Dockerfile
	docker rmi `docker images | python -c "import sys; print('\n'.join(l.split()[2] for l in sys.stdin if '<none>' in l))"`

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

push_amazon:
	`aws ecr --region us-east-1 get-login --no-include-email`
	docker tag rust_stable:latest_amazon ${aws_release}.dkr.ecr.us-east-1.amazonaws.com/rust_stable:latest_amazon
	docker push ${aws_release}.dkr.ecr.us-east-1.amazonaws.com/rust_stable:latest_amazon
	docker rmi ${aws_release}.dkr.ecr.us-east-1.amazonaws.com/rust_stable:latest_amazon

pull_amazon:
	`aws ecr --region us-east-1 get-login --no-include-email`
	docker pull ${aws_release}.dkr.ecr.us-east-1.amazonaws.com/rust_stable:latest_amazon
	docker tag ${aws_release}.dkr.ecr.us-east-1.amazonaws.com/rust_stable:latest_amazon rust_stable:latest_amazon
	docker rmi ${aws_release}.dkr.ecr.us-east-1.amazonaws.com/rust_stable:latest_amazon
