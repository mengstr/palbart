.PHONY:	clean check docker

all: palbart

palbart: palbart.c
	$(CC) -Wall -Werror -O2 -o $@ $<

check: palbart
	./palbart tests/hello.pal | tee check.log
	@if [ "$$(grep -ao 'No detected errors' tests/hello.lst | wc -l)" -ne "1" ]; then false; fi

# Compile the code inside a docker container using this Makefile again
docker:	
	docker run --rm -v "$(PWD)":/usr/src/myapp -w /usr/src/myapp gcc:latest make

clean:
	rm -f palbart *.log *~ tests/*.err tests/*.bin tests/*.lst tests/*.rim
	
	
