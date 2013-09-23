#!/bin/bash

coffee ./server/index.coffee &
PID=$!
grunt test:casperjs
kill -9 "$PID"
