# Eureka Server

This is a Spring Cloud Eureka Server implementation that serves as a service discovery server for microservices architecture.

## Overview

The Eureka Server is a crucial component in microservices architecture that enables service discovery and registration. It allows microservices to register themselves and discover other services in the network.

## Technical Stack

- Java 17
- Spring Boot 3.4.4
- Spring Cloud 2024.0.1
- Netflix Eureka Server

## Configuration

The server is configured with the following properties:
- Server Port: 8762
- Application Name: discovery-service
- Eureka Client Configuration:
  - Self-registration disabled
  - Registry fetching disabled
- Logging Level: INFO for Eureka components

## Dependencies

The project uses the following main dependencies:
- spring-boot-starter-web
- spring-cloud-starter-netflix-eureka-client
- spring-cloud-starter-netflix-eureka-server

## Building and Running

### Prerequisites
- Java 17 or higher
- Maven

### Build
```bash
mvn clean install
```

### Run
```bash
mvn spring-boot:run
```

## Docker Support

The project includes Docker support with:
- Dockerfile for containerization
- .dockerignore for excluding unnecessary files
- settings.xml for Maven configuration

## Accessing the Eureka Dashboard

Once the server is running, you can access the Eureka dashboard at:
```
http://localhost:8762
```

## Development

This project uses:
- Maven for dependency management and build
- Spring Boot for application framework
- Spring Cloud Netflix Eureka for service discovery

## License

This project is licensed under the standard Spring Boot license.