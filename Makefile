default:

install:

check:
	docker --version


PREFIX ?= bvberkum
DEFAULT_TAG ?= $(DOCKER_TAG)
DEFAULT_TAG ?= dev

BUILD_FLAGS ?=


build: 
	make build\:alpine-bats
	make build\:alpine-bats_dev
	make build\:alpine-bats_dev TAG=latest
	make build\:alpine-bats_dev TAG=3.6
	make build\:debian-bats
	make build\:debian-bats TAG=sid
	make build\:debian-bats TAG=stable
	make build\:debian-bats TAG=unstable
	make build\:debian-bats_dev
	make build\:debian-bats_dev TAG=sid
	make build\:debian-bats_dev TAG=stable
	make build\:debian-bats_dev TAG=unstable
	make build\:alpine-docker
	make build\:alpine-docker TAG=3.6
	make build\:alpine-docker TAG=latest
	#make build\:debian-docker
	make build\:ubuntu-docker
	make build\:debian-docker TAG=sid
	make build\:debian-docker TAG=unstable
	make build\:ubuntu-docker

test: test-bats test-docker

# Run against local test dir
test-bats: ARGS := test/*-spec.bats
test-bats:
	make run:alpine-bats ARGS=$(ARGS)
	make run:alpine-bats_dev ARGS=$(ARGS)
	make run:debian-bats ARGS=$(ARGS)
	make run:debian-bats TAG=sid ARGS=$(ARGS)
	make run:debian-bats TAG=stable ARGS=$(ARGS)
	make run:debian-bats TAG=unstable ARGS=$(ARGS)
	make run:debian-bats_dev ARGS=$(ARGS)
	make run:debian-bats_dev TAG=sid ARGS=$(ARGS)
	make run:debian-bats_dev TAG=stable ARGS=$(ARGS)
	make run:debian-bats_dev TAG=unstable ARGS=$(ARGS)

test-other-bats:
	#make run:alpine-bats							     FLAGS="-e X_DCKR_APK='git' "	ARGS="-- git clone $(GIT_URL) /tmp/project -- cd /tmp/project -- git checkout $(GIT_BRANCH) -- bats test"
	make run:alpine-bats_dev	 			         FLAGS="-e X_DCKR_APK='git' "	ARGS="-- git clone $(GIT_URL) /tmp/project -- cd /tmp/project -- git checkout $(GIT_BRANCH) -- bats test"
	#make run:debian-bats							     FLAGS="-e X_DCKR_APT='git' "	ARGS="-- git clone $(GIT_URL) /tmp/project -- cd /tmp/project -- git checkout $(GIT_BRANCH) -- bats test"
	#make run:debian-bats TAG=sid			     FLAGS="-e X_DCKR_APT='git' "	ARGS="-- git clone $(GIT_URL) /tmp/project -- cd /tmp/project -- git checkout $(GIT_BRANCH) -- bats test"
	#make run:debian-bats TAG=stable		   FLAGS="-e X_DCKR_APT='git' "	ARGS="-- git clone $(GIT_URL) /tmp/project -- cd /tmp/project -- git checkout $(GIT_BRANCH) -- bats test"
	#make run:debian-bats TAG=unstable     FLAGS="-e X_DCKR_APT='git' "	ARGS="-- git clone $(GIT_URL) /tmp/project -- cd /tmp/project -- git checkout $(GIT_BRANCH) -- bats test"
	make run:debian-bats_dev							 FLAGS="-e X_DCKR_APT='git' "	ARGS="-- git clone $(GIT_URL) /tmp/project -- cd /tmp/project -- git checkout $(GIT_BRANCH) -- bats test"
	make run:debian-bats_dev TAG=sid			 FLAGS="-e X_DCKR_APT='git' "	ARGS="-- git clone $(GIT_URL) /tmp/project -- cd /tmp/project -- git checkout $(GIT_BRANCH) -- bats test"
	make run:debian-bats_dev TAG=stable	 FLAGS="-e X_DCKR_APT='git' "	ARGS="-- git clone $(GIT_URL) /tmp/project -- cd /tmp/project -- git checkout $(GIT_BRANCH) -- bats test"
	make run:debian-bats_dev TAG=unstable FLAGS="-e X_DCKR_APT='git' "	ARGS="-- git clone $(GIT_URL) /tmp/project -- cd /tmp/project -- git checkout $(GIT_BRANCH) -- bats test"

# XXX: official bats tests seems to have a failure crept in. Not showing in my
# fork.
test-official-bats: GIT_BRANCH ?= master
test-official-bats:
	make test-other-bats GIT_URL=https://github.com/sstephenson/bats.git GIT_BRANCH=$(GIT_BRANCH)

#
# Docker Build in <*>/<TAG> subdir
#
build\:%: TAG ?= $(DEFAULT_TAG)
build\:%:
	@# XXX: hooks/build...
	test -d ./_/$*/$(TAG) && { cd ./_/$*/$(TAG) ; } || { cd ./_/$*/ ; } ;\
	docker build $(BUILD_FLAGS) \
		--build-arg X_DCKR_TAG=$(TAG) \
		--build-arg X_DCKR_PREFIX=$(PREFIX) \
		--build-arg X_DCKR_BASENAME=$* \
		--build-arg X_DCKR_NAME=$(PREFIX)/$* \
		-t $*:$(TAG) .

build\:alpine-bats: DEFAULT_TAG := edge
build\:debian-bats: DEFAULT_TAG := latest
build\:alpine-docker: DEFAULT_TAG := edge
build\:debian-docker: DEFAULT_TAG := sid
build\:ubuntu-docker: DEFAULT_TAG := xenial

build\:alpine-bats_dev: DEFAULT_TAG := edge
build\:alpine-bats_dev: BUILD_FLAGS := \
	--build-arg BATS_DEV_REPO=https://github.com/bvberkum/bats.git \
	--build-arg BATS_DEV_BRANCH=master

build\:debian-bats_dev: DEFAULT_TAG := latest
build\:debian-bats_dev: BUILD_FLAGS := \
	--build-arg BATS_DEV_REPO=https://github.com/bvberkum/bats.git \
	--build-arg BATS_DEV_BRANCH=master

build\:treebox: DEFAULT_TAG := treebox-local

#
# Docker Run <FLAGS> <*>:<TAG> [<ARGS>]
#
RUN_FLAGS := -ti --rm
run\:%: TAG ?= $(DEFAULT_TAG)
run\:%: LOCAL ?= true
run\:%:
	test "$(LOCAL)" = false && \
	docker run $(RUN_FLAGS) $(FLAGS) $(PREFIX)/$*:$(TAG) $(ARGS) || \
	docker run $(RUN_FLAGS) $(FLAGS) $*:$(TAG) $(ARGS)


run\:alpine-bats: DEFAULT_TAG := edge
run\:alpine-bats: ARGS := test
run\:alpine-bats: FLAGS := -v $(shell pwd -P):/project 

run\:alpine-bats_dev: DEFAULT_TAG := edge
run\:alpine-bats_dev: ARGS := test
run\:alpine-bats_dev: FLAGS := -v $(shell pwd -P):/project 

run\:debian-bats: DEFAULT_TAG := latest
run\:debian-bats: ARGS := test
run\:debian-bats: FLAGS := -v $(shell pwd -P):/project 

run\:debian-bats_dev: DEFAULT_TAG := latest
run\:debian-bats_dev: ARGS := test
run\:debian-bats_dev: FLAGS := -v $(shell pwd -P):/project 



test-docker:
	docker run --rm -ti alpine-docker:edge
	docker run --rm -ti -v /var/run/docker.sock:/var/run/docker.sock \
		alpine-docker:edge docker ps

update:
	./bin/x-docker.sh git-update-downstream

