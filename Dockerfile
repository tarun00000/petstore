FROM maven:3.5-jdk-8
COPY . /usr/src/app
WORKDIR /usr/src/app
RUN mvn clean install -DskipTests

WORKDIR /usr/src/app/target
CMD ["java","-jar","spring-petclinic-2.3.1.BUILD-SNAPSHOT.jar"]
## docker build -t [name of image]:[version] .     build and image
# docker images
#docker run  -p 8080:8080 [name of image]:[version]:v1    ***********run a conatiner
#docker run -p <hostport>:<containerport> imageName

# docker ps -a           **************List running containers

#scp -r -i "docker_day2.pem" jb//lec\ 2/Docker/spring-petclinic/* ubuntu@ec2-184-73-4-59.compute-1.amazonaws.com:~/Desktop/