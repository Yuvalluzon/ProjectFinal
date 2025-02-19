#!/bin/bash
New_tag=$1
ssh ubuntu@3.85.43.195 mkdir -p GYM-protfolio
ssh ubuntu@3.85.43.195 mkdir -p GYM-protfolio/nginx
ssh ubuntu@3.85.43.195 mkdir -p GYM-protfolio/templates
scp ./requirements.txt  ubuntu@3.85.43.195:/home/ubuntu/GYM-protfolio
scp ./mongo.dockerfile  ubuntu@3.85.43.195:/home/ubuntu/GYM-protfolio
scp ./nginx.dockerfile  ubuntu@3.85.43.195:/home/ubuntu/GYM-protfolio
scp ./docker-compose-prod.yaml  ubuntu@3.85.43.195:/home/ubuntu/GYM-protfolio
scp ./init-db.js ubuntu@3.85.43.195:/home/ubuntu/GYM-protfolio
scp ./app.py ubuntu@3.85.43.195:/home/ubuntu/GYM-protfolio
scp ./nginx/nginx.conf ubuntu@3.85.43.195:/home/ubuntu/GYM-protfolio/nginx
scp ./templates/index.html ubuntu@3.85.43.195:/home/ubuntu/GYM-protfolio/templates
scp ./deploy.sh ubuntu@3.85.43.195:/home/ubuntu/GYM-protfolio
ssh ubuntu@3.85.43.195 ./GYM-protfolio/deploy.sh $New_tag
