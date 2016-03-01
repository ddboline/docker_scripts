all:
	cp ../run_testing*.sh .
	cp ../keys_20151018.tar.gz .
	docker build --no-cache=true -t ddboline/ddboline_keys:v0.7.6.0 .

clean:
	rm run_testing*.sh keys_20151018.tar.gz
