#!/bin/bash

source ./script/lib/server

startServer
grunt test:casperjs
stopServer
