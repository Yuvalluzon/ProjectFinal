New_tag=$1
export New_tag
docker rmi $(docker images -aq)
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 891377258905.dkr.ecr.us-east-1.amazonaws.com
docker pull 891377258905.dkr.ecr.us-east-1.amazonaws.com/projectfinal:${New_tag}
cd GYM-protfolio
docker compose -f docker-compose-prod.yaml  build --no-cache
docker compose -f docker-compose-prod.yaml up -d
sleep 10
curl 3.85.43.195:80 
