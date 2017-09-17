default:

install:

check:
	docker --version


PREFIX ?= bvberkum
DEFAULT_TAG ?= $(DOCKER_TAG)
DEFAULT_TAG ?= dev


build: 
	make build\:alpine-bats
	make build\:debian-bats
	make build\:debian-bats TAG=sid
	make build\:debian-bats TAG=stable
	make build\:debian-bats TAG=unstable

test: test-bats

# Run against local test dir
test-bats: ARGS := test/*-spec.bats
test-bats:
	make run:alpine-bats ARGS=$(ARGS)
	make run:debian-bats ARGS=$(ARGS)
	make run:debian-bats TAG=sid ARGS=$(ARGS)
	make run:debian-bats TAG=stable ARGS=$(ARGS)
	make run:debian-bats TAG=unstable ARGS=$(ARGS)

# XXX: official bats tests seems to have a failure crept in
test-official-bats:
	make run:alpine-bats FLAGS="-e X_DCKR_APK='git' " ARGS="-- git clone https://github.com/sstephenson/bats.git -- cd bats -- bats test"
	make run:debian-bats FLAGS="-e X_DCKR_APT='git' " ARGS="-- git clone https://github.com/sstephenson/bats.git -- cd bats -- bats test"
	make run:debian-bats TAG=sid FLAGS="-e X_DCKR_APT='git' " ARGS="-- git clone https://github.com/sstephenson/bats.git -- cd bats -- bats test"
	make run:debian-bats TAG=stable FLAGS="-e X_DCKR_APT='git' " ARGS="-- git clone https://github.com/sstephenson/bats.git -- cd bats -- bats test"
	make run:debian-bats TAG=unstable FLAGS="-e X_DCKR_APT='git' " ARGS="-- git clone https://github.com/sstephenson/bats.git -- cd bats -- bats test"


#
# Docker Build in <*>/<TAG> subdir
#
build\:%: TAG ?= $(DEFAULT_TAG)
build\:%:
	test -e "$*/$(TAG)/Dockerfile" || \
		cp "$*/$(DEFAULT_TAG)/Dockerfile" "$*/$(TAG)/Dockerfile"
	@# XXX: hooks/build...
	cd $*/$(TAG) && docker build \
		--build-arg X_DCKR_TAG=$(TAG) \
		--build-arg X_DCKR_PREFIX=$(PREFIX) \
		--build-arg X_DCKR_BASENAME=$* \
		--build-arg X_DCKR_NAME=$(PREFIX)/$* \
		-t $*:$(TAG) .

build\:alpine-bats: DEFAULT_TAG := edge
build\:debian-bats: DEFAULT_TAG := latest


#
# Docker Run <FLAGS> <*>:<TAG> [<ARGS>]
#
RUN_FLAGS := -ti --rm
run\:%: TAG ?= $(DEFAULT_TAG)
run\:%:
	docker run $(RUN_FLAGS) $(FLAGS) $*:$(TAG) $(ARGS)

run\:alpine-bats: DEFAULT_TAG := edge
run\:alpine-bats: ARGS := test
run\:alpine-bats: FLAGS := -v $(shell pwd -P):/project 

run\:debian-bats: DEFAULT_TAG := latest
run\:debian-bats: ARGS := test
run\:debian-bats: FLAGS := -v $(shell pwd -P):/project 

