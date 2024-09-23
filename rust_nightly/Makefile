version := "0.1.0"
release := "1"
build_type := release
ubuntu_release := noble
aws_release := $(shell aws sts get-caller-identity | awk '/Account/ {print $2}' | sed 's:[",]::g')
docker_endpoint := "https://${aws_release}.dkr.ecr.us-east-1.amazonaws.com"

all:
	docker build --no-cache -f Dockerfile.${ubuntu_release} -t rust_nightly:${version} .
	docker tag rust_nightly:${version} rust_nightly:latest

update:
	docker build --no-cache -f Dockerfile.update -t rust_nightly:update .
	docker tag rust_nightly:update rust_nightly:latest

cleanup:
	rm Dockerfile
	docker rmi `docker images | python -c "import sys; print('\n'.join(l.split()[2] for l in sys.stdin if '<none>' in l))"`

push:
	echo `docker login -u AWS -p `aws ecr --region us-east-1 get-login-password` ${docker_endpoint}`
	docker login -u AWS -p `aws ecr --region us-east-1 get-login-password` ${docker_endpoint}
	docker tag rust_nightly:latest 281914939654.dkr.ecr.us-east-1.amazonaws.com/rust_nightly:latest
	docker push 281914939654.dkr.ecr.us-east-1.amazonaws.com/rust_nightly:latest
	docker rmi 281914939654.dkr.ecr.us-east-1.amazonaws.com/rust_nightly:latest

pull:
	docker login -u AWS -p `aws ecr --region us-east-1 get-login-password` ${docker_endpoint}
	docker pull 281914939654.dkr.ecr.us-east-1.amazonaws.com/rust_nightly:latest
	docker tag 281914939654.dkr.ecr.us-east-1.amazonaws.com/rust_nightly:latest rust_nightly:latest
	docker rmi 281914939654.dkr.ecr.us-east-1.amazonaws.com/rust_nightly:latest
