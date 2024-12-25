FROM jenkins/jenkins:lts

USER root

RUN apt-get update -y && \
    apt-get install docker.io -y 

RUN curl -SL https://github.com/docker/compose/releases/download/v2.16.0/docker-compose-linux-x86_64 -o /usr/local/bin/docker-compose

RUN chmod +x /usr/local/bin/docker-compose
 
RUN usermod -aG docker jenkins

RUN apt-get install awscli -y

USER jenkins 