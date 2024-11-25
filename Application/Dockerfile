# Use a lightweight base image with Java runtime
FROM openjdk:17-slim

# Set Datadog APM environment variables
ENV DD_SERVICE=hello-world-app
ENV DD_ENV=dev
ENV DD_VERSION=1.0.0
ENV DD_AGENT_HOST=localhost
ENV DD_TRACE_AGENT_PORT=8126

# Copy the Datadog Java Agent and application JAR file into the image
COPY dd-java-agent.jar /dd-java-agent.jar
COPY target/hello-world-app-1.0-SNAPSHOT.jar /app.jar
# Expose the default Spring Boot port
EXPOSE 8080

# Run the application with the Datadog APM Java agent
ENTRYPOINT ["java", "-javaagent:/dd-java-agent.jar", "-jar", "/app.jar"]
