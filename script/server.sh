#!/bin/bash

nodemon ./server/index.coffee --watch server &
PID=$!
grunt server
kill -9 "$PID"
