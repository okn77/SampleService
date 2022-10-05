FROM adoptopenjdk/openjdk8
EXPOSE 4444
ARG JAR_FILE=target/students-0.0.1-SNAPSHOT.jar
RUN addgroup -S pipeline && adduser -S mydevops2-pipeline -G pipeline
COPY ${JAR_FILE} /home/students-0.0.1-SNAPSHOT.jar
ENTRYPOINT ["java","-jar","/home/students-0.0.1-SNAPSHOT.jar"]
