FROM maven:3.8.5-openjdk-17 AS stage1
WORKDIR /home/app
COPY . /home/app
RUN mvn -f /home/app/pom.xml clean install

FROM openjdk:17-jdk-alpine
EXPOSE 8764
COPY --from=stage1 /home/app/target/discovery-service.jar discovery-service.jar
ENTRYPOINT ["sh", "-c","java -jar /discovery-service.jar"]