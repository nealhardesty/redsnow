#!/bin/bash
docker build -t redsnow $(dirname $0)
docker run -t --rm --name redsnow redsnow
