#! /bin/sh

docker-compose down

if [ -d timer-ui ]; then rm -rf timer-ui; fi
if [ -d timer-back ]; then rm -rf timer-back; fi
if [ -f .env ]; then rm -f .env; fi
