# PROJECT = lab
# DEPS = cowboy
# include ./deps/cowboy/erlang.mk

REBAR := ./rebar

all: get-deps compile 

get-deps:
	$(REBAR) get-deps

compile:
	$(REBAR) compile

.PHONY: all get-deps compile 
