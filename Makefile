REBAR := ./rebar

all: get-deps compile compile-app

get-deps:
	$(REBAR) get-deps

compile:
	$(REBAR) compile

.PHONY: all get-deps compile 