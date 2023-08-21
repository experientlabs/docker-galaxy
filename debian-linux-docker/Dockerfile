FROM python:3.10.9-buster

# Install Python 3 and pip
RUN apt-get update && apt-get install -y python3 python3-pip

# Set Python 3 as the default Python version
RUN ln -s /usr/bin/python3 /usr/bin/python

# Verify Python and pip installation
RUN python --version && pip3 --version

# Set the working directory
WORKDIR /app

# Copy your Java and Python files to the working directory
COPY . /app

# Set the entry point for running the Java application
# CMD ["java", "-jar", "your-java-application.jar"]
# CMD ["sh"]
# To keep the container running even after the shell session is closed, you can modify the CMD line in the Dockerfile as follows:
#CMD ["sh", "-c", "tail -f /dev/null"]
# To keep the container running and also rterun the cursor use below CMD,
 CMD ["sh", "-c", "exec sh -i"]