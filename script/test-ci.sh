#!/bin/bash

SERVER_PORT=5000

# start the backend server and wait till it's fully operational
PORT="$SERVER_PORT" coffee ./server/index.coffee &
while ! nc -vz localhost "$SERVER_PORT" &> /dev/null; do
  echo "Waiting for the backend server..."
  sleep 0.250
done

echo "Backend server is fully operational!"

# grab the PID
SERVER_PID=$!

# run all specs
grunt test:ci

# kill the backend server
kill -9 "$SERVER_PID"
