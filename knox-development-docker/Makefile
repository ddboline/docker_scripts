all: build

build:
	docker build -t knox/knox-dev:SNAPSHOT .

clean:
	rm -rf coverage/

cleanup:
	find . -iname '*.pyc' -exec rm {} \;
	docker rmi `docker images | python -c "import sys; print('\n'.join(l.split()[2] for l in sys.stdin if '<none>' in l))"` || true
