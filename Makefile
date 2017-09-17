default:

install:

check:
	docker --version


TAG ?= dev

#
# Docker Build in <*>/<TAG> subdir
#
build\:%:
	cd $*/$(TAG) && docker build -t $*:$(TAG) .

build\:alpine-bats: TAG := edge


#
# Docker Run <FLAGS> <*>:<TAG> [<ARGS>]
#
RUN_FLAGS := -ti --rm
run\:%:
	docker run $(RUN_FLAGS) $(FLAGS) $*:$(TAG) $(ARGS)

run\:alpine-bats: TAG := edge
run\:alpine-bats: FLAGS := -v $(shell pwd -P):/project 
run\:alpine-bats: ARGS := test

