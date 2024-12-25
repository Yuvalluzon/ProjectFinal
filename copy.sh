#!/bin/bash
New_tag=$1
ssh ubuntu@184.72.176.19 mkdir -p GYM-protfolio
ssh ubuntu@184.72.176.19 mkdir -p GYM-protfolio/nginx
ssh ubuntu@184.72.176.19 mkdir -p GYM-protfolio/templates
scp ./requirements.txt  ubuntu@184.72.176.19:/home/ubuntu/GYM-protfolio
scp ./mongo.dockerfile  ubuntu@184.72.176.19:/home/ubuntu/GYM-protfolio
scp ./nginx.dockerfile  ubuntu@184.72.176.19:/home/ubuntu/GYM-protfolio
scp ./docker-compose-prod.yaml  ubuntu@184.72.176.19:/home/ubuntu/GYM-protfolio
scp ./init-db.js ubuntu@184.72.176.19:/home/ubuntu/GYM-protfolio
scp ./app.py ubuntu@184.72.176.19:/home/ubuntu/GYM-protfolio
scp ./nginx/nginx.conf ubuntu@184.72.176.19:/home/ubuntu/GYM-protfolio/nginx
scp ./templates/index.html ubuntu@184.72.176.19:/home/ubuntu/GYM-protfolio/templates
scp ./deploy.sh ubuntu@184.72.176.19:/home/ubuntu/GYM-protfolio
ssh ubuntu@184.72.176.19 ./GYM-protfolio/deploy.sh $New_tag
