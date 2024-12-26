#!/bin/bash
New_tag=$1
ssh ubuntu@54.237.202.219 mkdir -p GYM-protfolio
ssh ubuntu@54.237.202.219 mkdir -p GYM-protfolio/nginx
ssh ubuntu@54.237.202.219 mkdir -p GYM-protfolio/templates
scp ./requirements.txt  ubuntu@54.237.202.219:/home/ubuntu/GYM-protfolio
scp ./mongo.dockerfile  ubuntu@54.237.202.219:/home/ubuntu/GYM-protfolio
scp ./nginx.dockerfile  ubuntu@54.237.202.219:/home/ubuntu/GYM-protfolio
scp ./docker-compose-prod.yaml  ubuntu@54.237.202.219:/home/ubuntu/GYM-protfolio
scp ./init-db.js ubuntu@54.237.202.219:/home/ubuntu/GYM-protfolio
scp ./app.py ubuntu@54.237.202.219:/home/ubuntu/GYM-protfolio
scp ./nginx/nginx.conf ubuntu@54.237.202.219:/home/ubuntu/GYM-protfolio/nginx
scp ./templates/index.html ubuntu@54.237.202.219:/home/ubuntu/GYM-protfolio/templates
scp ./deploy.sh ubuntu@54.237.202.219:/home/ubuntu/GYM-protfolio
ssh ubuntu@54.237.202.219 ./GYM-protfolio/deploy.sh $New_tag
