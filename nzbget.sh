#!/usr/bin/env bash

SERVICE="nzbget"
IMAGE="bluefishforsale/nzbget"
VERSION="latest"
LOCALDIR="/data01/services/${SERVICE}"
WORKDIR="/M2scratch/${SERVICE}"
DOWNLOADS="/data01/incoming"
MOVIES="/data01/complete/movies"
TV="/data01/complete/tv"

docker stop ${SERVICE}
docker rm ${SERVICE}


sudo docker run -d \
  --restart=always \
  --name=${SERVICE} \
  --hostname=${HOSTNAME} \
  -e PUID=1001 -e PGID=100\
  -p 6789:6789 \
  -v ${LOCALDIR}:/config \
  -v ${WORKDIR}:/scratch \
  -v ${MOVIES}:/movies \
  -v ${TV}:/tv \
  -v ${DOWNLOADS}:/downloads \
  ${IMAGE}:${VERSION}

docker logs ${SERVICE}
