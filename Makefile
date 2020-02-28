# WIN10 
GOCMD=go
GOBUILD=$(GOCMD) build

define BUILD
	echo Building $(1)
	dir
	cd .\$(1) && \
	${GOBUILD} -o ../out/$(1).exe
	cd ..

endef

PROJECTS = GoOpenGL Tree
all:
	$(foreach project,$(PROJECTS),$(call BUILD,$(project)))