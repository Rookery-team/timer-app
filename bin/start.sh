#! /bin/sh

if [ -d timer-ui ]; then rm -rf timer-ui; fi
git clone https://github.com/ipssi-timer/timer-front.git timer-ui
if [ -d timer-back ]; then rm -rf timer-back; fi
git clone https://github.com/ipssi-timer/timer-back.git timer-back
if [ -f .env ]; then rm -f .env; fi
cp -f .env.example .env

sudo docker-compose up
