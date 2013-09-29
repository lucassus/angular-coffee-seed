#!/bin/bash

source ./script/lib/server

startServer
grunt test:ci
stopServer
