FROM  maven:3-jdk-8-alpine

# creating the source dir
ENV APPLICATION_DIR /app
ENV SOURCE_DIR /src
RUN mkdir $APPLICATION_DIR && mkdir $SOURCE_DIR
WORKDIR $SOURCE_DIR

# selectively add the POM file
COPY pom.xml $SOURCE_DIR

# get all the downloads out of the way
RUN mvn dependency:resolve

# copy the source code
COPY . $SOURCE_DIR

# package the project
RUN mvn package
RUN cp /src/target/java-hello-world.war $APPLICATION_DIR

# remove source
# RUN rm -rf $SOURCE_DIR

# run the API
WORKDIR $APPLICATION_DIR
EXPOSE 8080
CMD [$APPLICATION_DIR]
