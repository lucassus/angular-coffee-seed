#!/bin/bash

nodemon ./server/index.coffee &
PID=$!
grunt server
kill -9 "$PID"
