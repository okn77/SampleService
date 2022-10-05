FROM adoptopenjdk/openjdk8
EXPOSE 4444
ARG JAR_FILE=target/students-0.0.1-SNAPSHOT.jar
RUN addgroup -S pipeline && adduser -S studentpipeline -G pipeline
COPY ${JAR_FILE} /home/studentpipeline/students-0.0.1-SNAPSHOT.jar
USER studentpipeline
ENTRYPOINT ["java","-jar","/home/studentpipeline/students-0.0.1-SNAPSHOT.jar"]

