#!/bin/bash
New_tag=$1
ssh ubuntu@18.168.150.55 mkdir -p GYM-protfolio
ssh ubuntu@18.168.150.55 mkdir -p GYM-protfolio/nginx
ssh ubuntu@18.168.150.55 mkdir -p GYM-protfolio/templates
scp ./requirements.txt  ubuntu@18.168.150.55:/home/ubuntu/GYM-protfolio
scp ./mongo.dockerfile  ubuntu@18.168.150.55:/home/ubuntu/GYM-protfolio
scp ./nginx.dockerfile  ubuntu@18.168.150.55:/home/ubuntu/GYM-protfolio
scp ./docker-compose-prod.yaml  ubuntu@18.168.150.55:/home/ubuntu/GYM-protfolio
scp ./init-db.js ubuntu@18.168.150.55:/home/ubuntu/GYM-protfolio
scp ./app.py ubuntu@18.168.150.55:/home/ubuntu/GYM-protfolio
scp ./nginx/nginx.conf ubuntu@18.168.150.55:/home/ubuntu/GYM-protfolio/nginx
scp ./templates/index.html ubuntu@18.168.150.55:/home/ubuntu/GYM-protfolio/templates
scp ./deploy.sh ubuntu@18.168.150.55:/home/ubuntu/GYM-protfolio
ssh ubuntu@18.168.150.55 ./GYM-protfolio/deploy.sh $New_tag
