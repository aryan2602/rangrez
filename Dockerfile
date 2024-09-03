FROM maven:3.8.8-amazoncorretto-8 AS build
COPY pom.xml .
RUN mvn clean package

FROM openjdk:21-slim

COPY target/rangrez-0.0.1-SNAPSHOT.jar /app/rangrez-0.0.1-SNAPSHOT.jar

LABEL maintainer="dhiraj deshmukh"


# Copy the built JAR file from the build stage
COPY target/rangrez-0.0.1-SNAPSHOT.jar rangrez-0.0.1-SNAPSHOT.jar

# Expose the port the app runs on
EXPOSE 8080

# Run the application
ENTRYPOINT ["java", "-jar", "rangrez-0.0.1-SNAPSHOT.jar"]