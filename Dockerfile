# Use an official OpenJDK image as a base image
FROM openjdk:17-jdk-slim AS build

# Set the working directory inside the container
WORKDIR /app

# Copy the project files into the container
COPY . .

# Install Maven
RUN apt-get update && apt-get install -y maven && rm -rf /var/lib/apt/lists/*

# Build the project using Maven
RUN mvn clean package -DskipTests

# Use a minimal OpenJDK runtime image
FROM openjdk:17-jdk-slim

# Set the working directory
WORKDIR /app

# Copy the compiled JAR file from the build stage
COPY --from=build /app/target/*.jar app.jar

# Expose the application port (change if necessary)
EXPOSE 8080

# Define the command to run the application
CMD ["java", "-jar", "app.jar"]
