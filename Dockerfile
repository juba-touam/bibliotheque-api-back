FROM ubuntu
RUN apt-get update && apt-get install openjdk-17-jdk curl vim -y
WORKDIR /opt
ADD target/bibliothequeApi-*.jar bibliotheque-api.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "/opt/bibliotheque-api.jar"]