#!/bin/bash

coffee ./server/index.coffee &
PID=$!
grunt test:ci
kill -9 "$PID"
