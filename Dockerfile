FROM maven:3.9.1-openjdk-21 AS build

# Set the working directory
WORKDIR /app

# Copy the Maven configuration file
COPY pom.xml .

# Download the dependencies
RUN mvn dependency:go-offline

# Copy the source code
COPY src /app/src

# Build the project
RUN mvn package

# Use the official OpenJDK 21 image to run the application
FROM openjdk:21-jdk-slim

# Set the working directory
WORKDIR /app

# Copy the built JAR file from the build stage
COPY --from=build /app/target/rangrez-0.0.1-SNAPSHOT.jar /app/rangrez-0.0.1-SNAPSHOT.jar

# Expose the port the app runs on
EXPOSE 8080

# Run the application
ENTRYPOINT ["java", "-jar", "/app/rangrez-0.0.1-SNAPSHOT.jar"]