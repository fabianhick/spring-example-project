FROM openjdk:8-jdk-alpine3.9 as build
WORKDIR /app
COPY . .
RUN ./mvnw package

FROM openjdk:8-jre-alpine3.9

WORKDIR /app
COPY --from=build /app/target/docker-example-1.1.3.jar ./docker-example-1.1.3.jar
RUN adduser -D app && \
    chown -R app /app

EXPOSE 8080

USER app

CMD java -jar ./docker-example-1.1.3.jar
