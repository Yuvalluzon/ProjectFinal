New_tag=$1
export New_tag
docker rmi $(docker images -aq)
aws ecr get-login-password --region eu-west-2 | docker login --username AWS --password-stdin 863254239753.dkr.ecr.eu-west-2.amazonaws.com
docker pull 863254239753.dkr.ecr.eu-west-2.amazonaws.com/yuval-klechevsky-repo:${New_tag}
cd GYM-protfolio
docker compose -f docker-compose-prod.yaml  build --no-cache
docker compose -f docker-compose-prod.yaml up -d
sleep 10
curl 18.168.150.55:80 
