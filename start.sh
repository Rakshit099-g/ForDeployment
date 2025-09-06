#!/bin/bash
set -e

echo "Building Spring Boot backend..."
cd spring-boot-server
mvn clean package -DskipTests
cd ..

echo "Building React frontend..."
cd react-client
npm install
npm run build
cd ..

echo "Copying React build into Spring Boot static folder..."
rm -rf spring-boot-server/src/main/resources/static/*
cp -r react-client/dist/* spring-boot-server/src/main/resources/static/

echo "Starting Spring Boot backend with embedded React frontend..."
cd spring-boot-server
java -jar target/*.jar --server.port=$PORT
