all:
	cp ../run_testing_local.sh .
	cp ../keys_vworld.tar.gz .
	docker build -t danielb/danielb_keys:v0.0.0.8 .

clean:
	rm run_testing*.sh keys_vworld.tar.gz
