PROJECT_ROOT = $(dir $(abspath $(lastword $(MAKEFILE_LIST))))

DOCKER_IMAGE ?= lambci/lambda-base-2:build

TARGET ?=/tmp

DOCKER = docker run -it --rm -w=/var/task/build

MOUNTS = -v $(PROJECT_ROOT):/var/task -v $(PROJECT_ROOT)result:$(TARGET)

build result:
	mkdir $@

clean:
	rm -rf build result

bash:
	$(DOCKER) $(MOUNTS) --entrypoint /bin/bash -t $(DOCKER_IMAGE)

all libs:
	$(DOCKER) $(MOUNTS) --entrypoint /usr/bin/make -t $(DOCKER_IMAGE) TARGET_DIR=$(TARGET) -f ../Makefile_Docker $@
