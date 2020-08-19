#! /bin/sh

sudo docker-compose down

if [ -d timer-ui ]; then sudo rm -rf timer-ui; fi
if [ -d timer-back ]; then sudo rm -rf timer-back; fi
if [ -f .env ]; then sudo rm -f .env; fi
