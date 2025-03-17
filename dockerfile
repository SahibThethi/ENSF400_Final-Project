# Use the official Gradle image with JDK 11 as the base image
FROM gradle:7.6.1-jdk11 AS build

# Set the working directory inside the container
WORKDIR /app

# Copy the Gradle configuration files and source code
COPY build.gradle ./desktop_app/settings.gradle ./
COPY gradle ./gradle
COPY gradlew gradlew.bat ./
COPY src ./src
COPY desktop_app ./desktop_app

# Build the project (this will also download dependencies)
RUN gradle build --no-daemon

# Final stage: Run the application
FROM gradle:7.6.1-jdk11
WORKDIR /app

# Copy the built JAR file from the root build/libs/ directory
COPY --from=build /app/build/libs/*.jar app.jar

# Expose the port (adjust if your app uses a specific port, e.g., 8080)
EXPOSE 8080

# Run the application
CMD ["java", "-jar", "app.jar"]