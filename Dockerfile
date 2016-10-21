# Version: 1
# Name: tomcat8
# Copy from thenewvu/oracle-jdk8
FROM yan047/jdk8

MAINTAINER "boyan.au@gmail.com"

ENV DEBIAN_FRONTEND noninteractive

# ENV JAVA_HOME /usr/lib/jvm/java-8-oracle

# add our user and group first to make sure their IDs get assigned consistently, regardless of whatever dependencies get added
RUN groupadd -r tomcat && useradd -r --create-home -g tomcat tomcat

ENV CATALINA_HOME /usr/local/tomcat
ENV PATH $CATALINA_HOME/bin:$PATH
RUN mkdir -p "$CATALINA_HOME" && chown tomcat:tomcat "$CATALINA_HOME"
WORKDIR $CATALINA_HOME
USER tomcat

ENV TOMCAT_MAJOR 8
ENV TOMCAT_VERSION 8.0.38
ENV TOMCAT_TGZ_URL https://www.apache.org/dist/tomcat/tomcat-$TOMCAT_MAJOR/v$TOMCAT_VERSION/bin/apache-tomcat-$TOMCAT_VERSION.tar.gz

RUN curl -SL "$TOMCAT_TGZ_URL" -o tomcat.tar.gz \
	&& tar -xvf tomcat.tar.gz --strip-components=1 \
	&& rm bin/*.bat \
	&& rm tomcat.tar.gz* \
	&& rm -rf webapps/host* \
	&& rm -rf webapps/manager \
	&& rm -rf webapps/examples \
	&& rm -rf webapps/docs
USER root

