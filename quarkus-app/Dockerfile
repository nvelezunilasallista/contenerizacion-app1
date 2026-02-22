# ── ETAPA 1: Build con Maven ─────────────────────────────────────────────────
FROM maven:3.9.6-eclipse-temurin-17 AS build
WORKDIR /app
COPY pom.xml .
RUN mvn dependency:go-offline -q
COPY src ./src
RUN mvn package -DskipTests -q

# ── ETAPA 2: Runtime JRE Mínimo ──────────────────────────────────────────────
FROM eclipse-temurin:17-jre-alpine
WORKDIR /app
COPY --from=build /app/target/quarkus-app ./quarkus-app
EXPOSE 8989
ENTRYPOINT ["java", "-jar", "quarkus-app/quarkus-run.jar"]
