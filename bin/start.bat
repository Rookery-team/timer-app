@echo off

git clone git@github.com:ipssi-timer/timer-front.git timer-ui
git clone git@github.com:ipssi-timer/timer-back.git timer-back
docker-compose up
