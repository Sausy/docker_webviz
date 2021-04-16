#!/usr/bin/env bash

echo "====[Start build/create docker Stuff] ====="
export $(cat .env | awk 'NR == 1')
export $(cat .env | awk 'NR == 2')
export $(cat .env | awk 'NR == 3')
export $(cat .env | awk 'NR == 4')

#=== parameterisize it =====
echo "======================="
echo "READING: .env file"
echo "Project name: $PROJECT_NAME"
echo "DockerHub USR: $DOCKHUB_USER"
echo "ARCHITECTUR: $ARCHITECTUR"
echo "ROS-Version: $ROSVERSION"
echo "........................"
echo "TIP: to change these vars"
echo "edit the '.env' file"
echo "======================="

PROJECT_NAME=webviz

postFix="${ARCHITECTUR}"
DOCKER_HUB_NAME="${DOCKHUB_USER}/${PROJECT_NAME}:${postFix}"

docker kill $PROJECT_NAME

echo "==========[${PROJECT_NAME}]============="
fallBack=0
read -p "Use prebuild container [Y/n]" -n 1 -r
if [[ ! $REPLY =~ ^[Nn]$ ]]
 then
 docker rmi -f $DOCKER_HUB_NAME
 docker pull $DOCKER_HUB_NAME || fallBack=1
 if [[ $fallBack -eq 1 ]]; then
  echo "[ERROR] THIS COINTAINER DOESN'T EXIST"
  echo "[INFO] Container will be rebuilt"
  #else
  #docker tag $DOCKER_HUB_NAME $DOCKER_IMAGE
 fi
else
 fallBack=1
fi

if [[ fallBack -eq 1 ]]
then
 docker stop $PROJECT_NAME
 #docker rmi -f $DOCKHUB_USER/$PROJECT_NAME
 docker rmi -f $DOCKER_HUB_NAME
 docker-compose build --force-rm "${PROJECT_NAME}_build"

 #==== push the clean image to docker hub====
 read -p "Push new container to dockerHub [Y/n]" -n 1 -r
 if [[ ! $REPLY =~ ^[Nn]$ ]]
 then
  docker push $DOCKER_HUB_NAME
 fi
fi
