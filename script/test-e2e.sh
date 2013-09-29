#!/bin/bash

source ./script/lib/server

startServer
grunt test:e2e
stopServer
