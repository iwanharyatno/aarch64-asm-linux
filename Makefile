.DEFAULT_GOAL := build

build:
	mkdir -p ./obj
	as -o ./obj/main.o main.s
	ld -s -o ./obj/main ./obj/main.o

debug:
	mkdir -p ./obj
	as -g -o ./obj/main.o main.s
	ld -o ./obj/main ./obj/main.o

run:
	@./obj/main
