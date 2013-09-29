#!/bin/bash

source ./script/lib/start_server

startServer
grunt test:ci
stopServer

exit 0
