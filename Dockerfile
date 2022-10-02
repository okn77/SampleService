FROM openjdk:8-jdk-alpine
EXPOSE 4444
ARG JAR_FILE=target/students-0.0.1-SNAPSHOT.jar
ADD ${JAR_FILE} students-0.0.1-SNAPSHOT.jar
ENTRYPOINT ["java","-jar","/students-0.0.1-SNAPSHOT.jar"]
