.PHONY: install build

build:
	echo "#!/usr/bin/env bash" > example3.sh
	which tree >> example3.sh

install:
	mkdir ${out}/bin # no -p here, $out already exists
	cp example3.sh ${out}/bin/example3.sh
	chmod +x ${out}/bin/example3.sh
