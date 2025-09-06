#!/bin/bash

# Exit on error
set -e

echo "Building Spring Boot backend..."
cd spring-boot-server

# Build backend (skip tests for faster deploy)
./mvnw clean package -DskipTests

# Go back to root
cd ..

echo "Building React frontend..."
cd react-client

# Install dependencies and build
npm install
npm run build

# Move frontend build to Spring Boot static folder
cd ..
rm -rf spring-boot-server/src/main/resources/static/*
cp -r react-client/build/* spring-boot-server/src/main/resources/static/

echo "Starting Spring Boot server..."
cd spring-boot-server

# Run backend
java -jar target/spring-boot-0.0.1-SNAPSHOT.jar
