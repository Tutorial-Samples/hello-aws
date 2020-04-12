## Stage 1 - Lets build the "deployable pacjage"
FROM maven:3.6.3-jdk-11 as hello-aws
WORKDIR /hello-aws

### Step 1: Copy pom.xml and download project dependencies

## Dividing copy into two steps to ensure that we download dependencies
## only when pom.xml changes
COPY pom.xml .
## dependency:go-offline - Goal that resolves all project dependencies,
## including plugins and reports and their dependencies. -B -> Batch mode
RUN mvn dependency:go-offline -B

## Step 2: Copy source and build "deployable package"
COPY src src
RUN mvn install

## Unzip
RUN mkdir -p target/dependency && (cd target/dependency; jar -xf ../*.jar)

## Stage 2: Let's build a minimal image with the "deployable package
## Stage 2 alone is good enough if we are building the image with
## maven dependency and spotify plugin, but that means we are tied to the
## maven version and JDK version that is tied to the machine that creates
## the image
FROM openjdk:11.0
VOLUME /tmp
EXPOSE 8080
##ADD target/*.jar app.jar
ARG DEPENDENCY=/hello-aws/target/dependency
COPY --from=hello-aws ${DEPENDENCY}/BOOT-INF/lib /app/lib
COPY --from=hello-aws ${DEPENDENCY}/META-INF /app/META-INF
COPY --from=hello-aws ${DEPENDENCY}/BOOT-INF/classes /app
##ENTRYPOINT ["sh", "-c", "java -jar /app.jar"]
ENTRYPOINT ["java","-cp","app:app/lib/*","com.hello.aws.HelloAwsApplication"]