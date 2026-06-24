# ---- Build stage: compila con JDK 21 + Maven dentro del contenedor ----
FROM maven:3.9-eclipse-temurin-21 AS build
WORKDIR /app
# Cache de dependencias (no fatal si no logra resolver todo offline)
COPY pom.xml .
RUN mvn -B -q dependency:go-offline || true
# Código y empaquetado
COPY src ./src
RUN mvn -q -B clean package -DskipTests

# ---- Runtime stage: JRE 21 ligero ----
FROM eclipse-temurin:21-jre-alpine
WORKDIR /app
COPY --from=build /app/target/quarkus-app/lib/ ./lib/
COPY --from=build /app/target/quarkus-app/*.jar ./
COPY --from=build /app/target/quarkus-app/app/ ./app/
COPY --from=build /app/target/quarkus-app/quarkus/ ./quarkus/
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "quarkus-run.jar"]
