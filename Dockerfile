FROM maven:3.9.9-amazoncorretto-23-alpine AS builder

WORKDIR /app

COPY .mvn /app/.mvn
COPY src /app/src
COPY pom.xml /app/pom.xml

RUN mvn package -f /app/pom.xml -DskipTest=true

FROM maven:3.9.9-amazoncorretto-23-alpine

WORKDIR /app/bin
COPY --from=builder "/app/target/d13revision-0.0.1-SNAPSHOT.jar" "/app/bin/cicd.jar"

ENV PORT=8084
EXPOSE ${PORT}

CMD ["java", "-jar", "/app/bin/cicd.jar"]