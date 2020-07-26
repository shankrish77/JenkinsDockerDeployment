#!/bin/sh


qq=$(docker service ls|grep "8080->8123"|grep -c tmp-svc)

#// --update-delay

if [ $qq -gt 0 ]; then
	echo "Doing a Rolling Update.. $1 "
	docker service update --env-add WEB=$2 --image $1 tmp-svc
else
	echo "Deploying Application.. $1"
	docker service create --name tmp-svc --replicas 2 --publish 8080:8123 --env WEB=$2 $1
fi