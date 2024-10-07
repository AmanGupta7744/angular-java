FROM ubuntu:20.04 AS builder
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
    apt-get install -y openjdk-8-jdk maven && \
    rm -rf /var/lib/apt/lists/*
WORKDIR /app
COPY . .
RUN mvn clean package -Dmaven.test.skip=true
FROM openjdk:8-jre-slim
WORKDIR /app
COPY --from=builder /app/target/spring-backend-v1.jar .
EXPOSE 8080
CMD ["java", "-jar", "spring-backend-v1.jar"]
