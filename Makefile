ODIR := out
LIB := RobotComms.a
FULL_LIB := $(ODIR)/$(LIB)

PROTOC := /usr/local/bin/protoc

CXX := g++
CXX_FLAGS := -fPIC -I$(ODIR)

AR := ar
AR_FLAGS := -crf

PROTO_SOURCES := $(wildcard *.proto)
PROTO := $(PROTO_SOURCES:%.proto=$(ODIR)/%.pb.cc)

all:
	make $(FULL_LIB)

$(PROTO_SOURCES):

$(PROTO): $(PROTO_SOURCES)
	@echo Generating Proto
	@mkdir -p $(ODIR)
	@$(PROTOC) --cpp_out=./$(ODIR) *.proto 

$(FULL_LIB): $(PROTO)
	@mkdir -p $(ODIR)
	@cd $(ODIR) && $(CXX) $(CXX_FLAGS) -c ./*.cc
	@$(AR) $(AR_FLAGS) $(FULL_LIB) $(ODIR)/*.o
	@echo Protobuf Library Built Successfully!

clean:
	@rm -rf $(ODIR)
