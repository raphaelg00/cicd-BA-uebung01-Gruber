# Dockerfile
# --- Build Stage ---
FROM maven:3.6.3-jdk-8 AS build
WORKDIR /app
COPY pom.xml .
RUN mvn -q -B -e -DskipTests dependency:go-offline
COPY src ./src
# build JAR
RUN mvn -q -B -e -DskipTests package && ls -la target

# --- Runtime Stage ---
FROM debian:stretch-slim
WORKDIR /app
RUN useradd -r -u 10001 appuser
COPY --from=build /app/target/*.jar /app/app.jar
USER appuser
ENTRYPOINT ["java","-jar","/app/app.jar"]
