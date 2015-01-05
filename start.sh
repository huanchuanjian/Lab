#!/bin/sh

erl -pa ebin/ -pa deps/*/ebin/ \
    -boot start_sasl \
    -name lab@127.0.0.1 \
    -s lab_app \
    -s reloader
