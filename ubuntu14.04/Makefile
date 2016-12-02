all:
	cp ../run_testing*.sh .
	cp ../keys_20161201.tar.gz .
	docker build --no-cache=true -t ddboline/ddboline_keys:v0.7.6.4 .

clean:
	rm run_testing*.sh keys_20161201.tar.gz
