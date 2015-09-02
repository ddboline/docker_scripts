all:
	cp ../run_testing*.sh
	cp ../keys_20150617.tar.gz .
	docker build -t ddboline/ddboline_keys:v0.8.2 .

clean:
	rm run_testing*.sh keys_20150617.tar.gz
