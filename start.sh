#!/bin/sh

erl -name lab@127.0.0.1 -pa ebin/ -pa deps/*/ebin/ \
    -s lab_app
