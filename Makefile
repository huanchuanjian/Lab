REBAR := ./rebar

all: get-deps compile 

get-deps:
	$(REBAR) get-deps

compile:
	$(REBAR) compile

.PHONY: all get-deps compile 
