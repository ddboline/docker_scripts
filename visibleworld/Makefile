all:
	cp ../run_testing_local.sh .
	cp ../keys_vworld.tar.gz .
	docker build -t danielb/danielb_keys:v1.0.0.7 .

clean:
	rm run_testing*.sh keys_vworld.tar.gz
