FROM openjdk:17-jdk-slim AS build

WORKDIR /app

# Copy the Maven wrapper and project definition file.
# This allows us to cache the dependency layer.
COPY .mvn/ .mvn
COPY mvnw pom.xml ./

# Make the Maven wrapper executable and download dependencies.
RUN chmod +x mvnw
RUN ./mvnw dependency:go-offline -B

# Copy the rest of the application's source code.
COPY src ./src

# Package the application into a JAR file, skipping tests for a faster build.
RUN ./mvnw package -DskipTests -B


# --- Stage 2: Create the final, secure, and optimized production image ---
# This stage uses a much smaller, more secure base image for the final product.
FROM eclipse-temurin:17-alpine

# Create a dedicated, non-root user for enhanced security.
RUN addgroup -g 1000 appgroup && \
    adduser -u 1000 -G appgroup -s /bin/sh -D appuser

WORKDIR /app

# --- FIX ---
# The line below has been changed to match the likely artifactId ('eureka-server')
# from your pom.xml, based on your project's folder name.
COPY --from=build /app/target/eureka-server-*.jar discovery-service.jar

# Assign ownership of the application file to the non-root user.
RUN chown appuser:appgroup discovery-service.jar

# Switch the container to run as the non-root user.
USER appuser

# Expose the port the Eureka server runs on.
EXPOSE 8761

# Set JVM options for better performance inside a container.
ENV JAVA_OPTS="-Xms256m -Xmx512m -XX:+UseG1GC -XX:+UseContainerSupport -XX:MaxRAMPercentage=75.0 -Djava.security.egd=file:/dev/./urandom"

# The command to run when the container starts.
ENTRYPOINT ["sh", "-c", "java $JAVA_OPTS -jar discovery-service.jar"]