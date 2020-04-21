.PHONY:	clean check docker

all: palbart

palbart: palbart.c
	$(CC) -Wall -Werror -O2 -o $@ $<

check: palbart
	./palbart -m tests/CHEKMO.PAL | tee check.log
	@if [ "$$(grep -ao 'Overlap in area' check.log | wc -l)" -ne "8" ]; then false; fi

# Compile the code inside a docker container using this Makefile again
docker:	
	docker run --rm -v "$(PWD)":/usr/src/myapp -w /usr/src/myapp gcc:latest make

clean:
	rm -f palbart *.log *~
	
