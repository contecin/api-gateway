FROM gradle:jdk17-alpine AS api_gateway

COPY . /home/gradle/source

WORKDIR /home/gradle/source

RUN gradle clean build

# actual container
FROM openjdk:17-alpine

COPY --from=api_gateway /home/gradle/source/build/libs/*-SNAPSHOT.jar /app/api_gateway.jar

WORKDIR /app

EXPOSE 8082

# ENTRYPOINT ["java","-jar","api_gateway.jar"]

ENTRYPOINT ["sh", "-c", "java ${JAVA_OPTS} -jar api_gateway.jar"]