# Step 1: Build the application
FROM maven AS build

# Set the working directory
WORKDIR /app

# Copy the pom.xml file and download dependencies
COPY pom.xml .

# Download the dependencies first to leverage Docker cache
RUN mvn dependency:go-offline -B

# Copy the source code to the container
COPY src ./src

# Build the application
RUN mvn clean install

# Step 2: Create the final image
FROM openjdk:21-slim

# Set the working directory in the final image
WORKDIR /app

# Copy the built JAR file from the build stage
COPY --from=build /app/target/rangrez-0.0.1-SNAPSHOT.jar rangrez-0.0.1-SNAPSHOT.jar

# Label for maintainer information
LABEL maintainer="dhiraj deshmukh"

# Expose the port the app runs on
EXPOSE 8080

# Run the application
ENTRYPOINT ["java", "-jar", "rangrez-0.0.1-SNAPSHOT.jar"]


