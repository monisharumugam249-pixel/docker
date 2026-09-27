# Use official Tomcat base image
FROM tomcat:9.0-jdk21-openjdk

# Set working directory inside container
WORKDIR /usr/local/tomcat

# Copy your WAR file from Jenkins workspace into Tomcat webapps
# Replace *.war with the actual WAR filename (e.g., docker_test.war)
COPY target/sample-webapp.war /usr/local/tomcat/webapps/app.war

# Expose Tomcat default port
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]
