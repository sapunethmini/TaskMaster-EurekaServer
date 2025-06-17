

# 🎯 Eureka Server

[![Build Status](https://img.shields.io/badge/build-passing-brightgreen.svg)]()
[![Version](https://img.shields.io/badge/version-1.0.0-blue.svg)]()

> Netflix Eureka Server for service discovery and registration in the Task Management Platform.

## 🎯 Service Overview

Eureka Server provides:
- **Service Registration**: Microservices register themselves
- **Service Discovery**: Services locate each other
- **Health Monitoring**: Tracks service health status
- **Load Balancing**: Enables client-side load balancing
- **Fault Tolerance**: Handles service failures gracefully

## 🚀 Quick Start

```bash
# Clone and navigate
cd eureka-server

# Run the service
mvn spring-boot:run

# Access Eureka Dashboard
open http://localhost:8761
```

## 🔧 Configuration

### application.yml

```yaml
server:
  port: 8761

spring:
  application:
    name: eureka-server

eureka:
  instance:
    hostname: localhost
  client:
    register-with-eureka: false
    fetch-registry: false
    service-url:
      defaultZone: http://${eureka.instance.hostname}:${server.port}/eureka/
  server:
    enable-self-preservation: false
    eviction-interval-timer-in-ms: 4000

management:
  endpoints:
    web:
      exposure:
        include: health,info,env

logging:
  level:
    com.netflix.eureka: INFO
    com.netflix.discovery: INFO
```

## 📊 Dashboard

Access the Eureka Dashboard at `http://localhost:8761` to view:
- Registered services
- Service instances
- Health status
- Configuration details

## 🐳 Docker Support

### API Gateway Dockerfile
```dockerfile
FROM openjdk:17-jre-slim
COPY target/api-gateway-1.0.0.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "/app.jar"]
```

### Eureka Server Dockerfile
```dockerfile
FROM openjdk:17-jre-slim
COPY target/eureka-server-1.0.0.jar app.jar
EXPOSE 8761
ENTRYPOINT ["java", "-jar", "/app.jar"]
```

## 🔄 Service Registration Flow

1. **Service Startup**: Each microservice starts and registers with Eureka
2. **Health Checks**: Eureka monitors service health via heartbeats
3. **Service Discovery**: API Gateway discovers services through Eureka
4. **Load Balancing**: Gateway distributes requests across healthy instances
5. **Failure Handling**: Eureka removes unhealthy instances from registry

## 🚀 Production Deployment

### High Availability Setup

```yaml
# Eureka Cluster Configuration
eureka:
  client:
    service-url:
      defaultZone: http://eureka1:8761/eureka/,http://eureka2:8762/eureka/
  server:
    enable-self-preservation: true
```

### Security Configuration

```yaml
security:
  basic:
    enabled: true
  user:
    name: ${EUREKA_USERNAME:admin}
    password: ${EUREKA_PASSWORD:password}
```

## 📚 Related Documentation

- [Main Project README](../README.md)
- [User Service](../user-service/README.md)
- [Task Service](../task-service/README.md)
- [Notification Service](../notification-service/README.md)
