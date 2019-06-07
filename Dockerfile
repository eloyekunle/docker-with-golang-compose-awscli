FROM docker:latest

RUN apk add --no-cache py-pip bash build-base
RUN pip install docker-compose awscli ecs-deploy
