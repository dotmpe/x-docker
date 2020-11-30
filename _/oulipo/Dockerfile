#FROM gradle:4.10-jdk8 as builder
#FROM renovate/gradle as builder
FROM niccomlt/gradle-javafx as builder


COPY --chown=gradle:gradle oulipo /home/gradle/oulipo-src
WORKDIR /home/gradle/oulipo-src
RUN gradle build

#FROM openjdk:10-jre-slim
#EXPOSE 8080
#COPY --from=builder /home/gradle/src/easytext.web/build/distributions/easytext.web.tar /app/
#WORKDIR /app
#RUN tar -xvf easytext.web.tar
#WORKDIR /app/easytext.web
#CMD bin/easytext.web

#ENTRYPOINT ["java", "-Dorg.gradle.appname=oulipo", "-classpath", "$PWD/gradle/wrapper/gradle-wrapper.jar", "org.gradle.wrapper.GradleWrapperMain"]
