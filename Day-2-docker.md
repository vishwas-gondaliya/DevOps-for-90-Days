Docker readme:

docker ps
docker ps -a
docker images
docker rm container
docker rmi images
docker rm $(docker ps -aq)

to remove all images
docker rmi $(docker images -q)
docker image prune -a


docker run -d --name web1 -p 8080(Hostport):80(Containerport) nginx
docker logs web1
docker inspect web1

Dockerfile

FROM python:3.9-slim
WORKDIR /app
COPY app.py .
EXPOSE 5050 - it is only used for documentation as long as you are mentioning port while running container
CMD ["python","app.py"] it will execute this command while running the app


Difference between RUN and CMD, run execute command when image is building while CMD executes when we run container.

docker build -t name-of-image . - . suggest path of dockerfile

Note: EXPOSE in dockerfile is only for documentation, EXPOSE is never “used” unless tooling like -P, docker-compose, or orchestrators reference it.