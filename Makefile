ARCH := $(shell arch)
ODIR := out
LIB := RobotComms.a
FULL_LIB := $(ODIR)/$(ARCH)/$(LIB)

CXX_FLAGS := -fPIC -I$(ODIR)

PROTO_SOURCES := $(wildcard *.proto)
PROTO := $(PROTO_SOURCES:%.proto=$(ODIR)/%.pb.cc)

all:
	make $(FULL_LIB)

$(PROTO_SOURCES):

$(PROTO): $(PROTO_SOURCES)
	@echo Generating Proto
	@mkdir -p out
	@/usr/local/bin/protoc --cpp_out=./out *.proto 

$(FULL_LIB): $(PROTO)
	mkdir -p $(ODIR)/$(ARCH)
	cd $(ODIR)/$(ARCH) && $(CXX) $(CXX_FLAGS) -c ../*.cc
	ar -crfv $(FULL_LIB) $(ODIR)/$(ARCH)/*.o

clean:
	@rm -rf $(ODIR)
