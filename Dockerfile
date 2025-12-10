# Dockerfile
# --- Build Stage ---
FROM maven:3.9.9-eclipse-temurin-21 AS build
WORKDIR /app
COPY pom.xml .
RUN mvn -q -B -e -DskipTests dependency:go-offline
COPY src ./src
# build JAR
RUN mvn -q -B -e -DskipTests package && ls -la target

# --- Runtime Stage ---
FROM eclipse-temurin:21-jre-alpine
WORKDIR /app
RUN apk --no-cache add shadow && \
    useradd -r -u 10001 appuser && \
    apk del shadow
COPY --from=build /app/target/*.jar /app/app.jar
USER appuser
ENTRYPOINT ["java","-jar","/app/app.jar"]
