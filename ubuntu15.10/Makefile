all:
	cp ../run_testing*.sh .
	cp ../keys_20151018.tar.gz .
	docker build --no-cache=true -t ddboline/ddboline_keys:wily_v0.0.2 .

clean:
	rm run_testing*.sh keys_20151018.tar.gz
