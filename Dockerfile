FROM openjdk:11.0

VOLUME /tmp
ADD maven/*.jar app.jar
RUN sh -c 'touch app.jar'
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/app.jar"]