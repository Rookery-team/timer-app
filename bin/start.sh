#! /bin/sh

if [ -d timer-ui ]; then rm -rf timer-ui; fi
git clone git@github.com:ipssi-timer/timer-front.git timer-ui
if [ -d timer-back ]; then rm -rf timer-back; fi
git clone git@github.com:ipssi-timer/timer-back.git timer-back
sudo docker-compose up
