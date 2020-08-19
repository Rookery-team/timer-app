@echo off

docker-compose down

if exist timer-ui (rmdir timer-ui)
if exist timer-back (rmdir timer-back)
if exist .env (rm .env)
