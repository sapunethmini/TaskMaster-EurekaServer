# Use Maven image for building
FROM maven:3.9.6-eclipse-temurin-17 AS build

# Set working directory
WORKDIR /app

# Copy settings.xml for Maven configuration
COPY settings.xml /usr/share/maven/conf/settings.xml

# Copy pom.xml first (for better caching)
COPY pom.xml ./

# Download dependencies (this layer will be cached unless pom.xml changes)
RUN mvn dependency:go-offline -B

# Copy source code
COPY src ./src

# Build the application
RUN mvn clean package -DskipTests

# Use OpenJDK for runtime
FROM openjdk:17-jdk-slim

WORKDIR /app

# Copy the built JAR from build stage
COPY --from=build /app/target/*.jar app.jar

# Expose the port Eureka Server runs on
EXPOSE 8761

# Run the application
CMD ["java", "-jar", "app.jar"]