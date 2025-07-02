# Stage 1: Run tests
FROM maven:3.9.5-eclipse-temurin-17 AS test
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn test

# Stage 2: Build artifact (skip tests since they already passed)
FROM maven:3.9.5-eclipse-temurin-17 AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

# Stage 3: Dev environment (for local development)
FROM maven:3.9.5-eclipse-temurin-17 AS dev
WORKDIR /app

# Copy full project (for rebuilds, dev iterations)
COPY . .

# Optional: run app with live reload or simply repackage on every run
# You can override this CMD in docker-compose or locally
CMD ["mvn", "spring-boot:run"]

# Stage 4: Final runtime image (lightweight, secure)
FROM eclipse-temurin:17

# Create non-root user and group
RUN addgroup --system appgroup && adduser --system appuser --ingroup appgroup

WORKDIR /app

# Copy only the built jar from the build stage
COPY --from=build /app/target/*.jar app.jar

USER appuser

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]
