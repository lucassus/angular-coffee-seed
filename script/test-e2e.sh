#!/bin/bash

coffee ./server/index.coffee &
PID=$!
grunt test:e2e
kill -9 "$PID"
