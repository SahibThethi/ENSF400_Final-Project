FROM gradle:7.6.4-jdk11 AS builder
WORKDIR /app
COPY . .
RUN gradle build

FROM tomcat:9.0
COPY --from=builder /app/build/libs/app-1.0.0.war /usr/local/tomcat/webapps/demo.war
EXPOSE 8080
CMD ["catalina.sh", "run"]
