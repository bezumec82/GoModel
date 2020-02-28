# Go parameters
GOCMD=go
GOBUILD=$(GOCMD) build

OUTPUT_DIR=./out

all: build

build:
	echo "Building GoOGL"
	cd GoOGL
	${GOBUILD} -o ${OUTPUT_DIR}/GoOGL.exe