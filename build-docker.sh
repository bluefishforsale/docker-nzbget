#!/bin/bash

BUILD=latest
SERVICE=nzbget
USER=bluefishforsale

docker build --pull --tag ${USER}/${SERVICE}:${BUILD} .
