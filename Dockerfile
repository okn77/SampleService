FROM adoptopenjdk/openjdk8
EXPOSE 4444
ARG JAR_FILE=target/students-0.0.1-SNAPSHOT.jar

RUN apt-get update && \
      apt-get -y install sudo


# Set USER and GROUP 
ARG USER=developer
ARG GROUP=developer
RUN addgroup --gid 1000 $USER && \
    adduser --uid 1000 --ingroup $USER --home /home/$USER --shell /bin/sh --disabled-password --gecos "" $USER




RUN adduser $USER sudo \
 && echo "$USER ALL=NOPASSWD: ALL" >> /etc/sudoers.d/$USER
 

 

# Commands below run as the developer user.
USER $USER:$GROUP

# When running a container start in the developer's home folder.
WORKDIR /home/$USER
	


COPY ${JAR_FILE} $WORKDIR/students-0.0.1-SNAPSHOT.jar
USER $USER
ENTRYPOINT ["java","-jar","$WORKDIR/students-0.0.1-SNAPSHOT.jar"]

