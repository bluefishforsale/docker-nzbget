#!/usr/bin/env bash

SERVICE="nzbget"
IMAGE="bluefishforsale/nzbget"
VERSION="latest"
LOCALDIR="/data01/services/${SERVICE}"
DOWNLOADS="/data01/incoming"
MOVIES="/data01/complete/movies"
TV="/data01/complete/tv"

docker stop ${SERVICE}
docker rm ${SERVICE}

docker images | egrep "${IMAGE}\ *${VERSION}" | awk '{print $3}' | xargs docker rmi


sudo docker run -d \
  --restart=always \
  --cpu-shares=600 \
  --name=${SERVICE} \
  --hostname=${HOSTNAME} \
  -e PUID=1001 -e PGID=100\
  -p 8901:8901 \
  -v ${LOCALDIR}/config:/config \
  -v ${LOCALDIR}/scratch:/scratch \
  -v ${MOVIES}:/movies \
  -v ${TV}:/tv \
  -v ${DOWNLOADS}:/downloads \
  ${IMAGE}:${VERSION}

docker logs ${SERVICE}
