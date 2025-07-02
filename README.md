# Multi-Stage Dockerfile Example for Java Applications

This project demonstrates how to properly containerize a Java application using a multi-stage Dockerfile.

Many early Docker setups combine all steps—build, test, and run—into a single stage. While this might work, it often leads to large, insecure, and inefficient containers that contain unnecessary tools and dependencies. This repository shows how to improve that using multi-stage builds.

## Why Multi-Stage Builds?

Using Docker multi-stage builds provides the following benefits:

- Clean separation of concerns: testing, building, development, deployment
- Smaller and production-ready final image
- Better security by removing build tools and using a non-root user
- Improved Docker caching: only rebuild what's necessary
- Flexibility to build or run specific stages (with `--target`)

## Dockerfile Stages

The Dockerfile defines four stages:

1. `test`: Runs unit tests using Maven. If any test fails, the build stops.
2. `build`: Compiles the Java application and generates a JAR file. Skips tests assuming they were already run.
3. `dev`: Provides a full Maven development environment with source code. Useful for development using `spring-boot:run`.
4. `final`: Produces a lightweight, secure image for production containing only the compiled JAR and JDK.

## How to Use

### Build the Full Production Image

This builds the entire pipeline: test → build → final.

```bash
docker build -t myapp .
```

### Build the Dev Image

```bash
docker build --target dev -t myapp-dev .
```
