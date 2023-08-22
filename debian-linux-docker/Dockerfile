FROM python:3.10.9-buster

###########################################
# Upgrade the packages
###########################################
# Download latest listing of available packages:
RUN apt-get -y update
# Upgrade already installed packages:
RUN apt-get -y upgrade

# Install new packages:
RUN apt-get update --yes && \
    apt-get install --yes --no-install-recommends \
    ca-certificates curl zip unzip vim sudo wget && \
    apt-get clean && rm -rf /var/lib/apt/lists/*


############################################
# create group and user
############################################

ARG UNAME=sam
ARG GID=1000
ARG PASSWORD=mypwd

RUN cat /etc/passwd

# create group
RUN groupadd -g $GID $UNAME

# create a user without specifying UID
RUN useradd -g $GID -m -s /bin/bash $UNAME

# change permissions of the user's home directory
RUN chown $UNAME:$GID /home/$UNAME

# Set password for the user
RUN echo "$UNAME:$PASSWORD" | chpasswd

# give sudo access to the user
RUN echo "$UNAME ALL=(ALL) ALL" >> /etc/sudoers


###########################################
# change working dir and user
###########################################

USER $UNAME

# Set the working directory
RUN mkdir -p /home/$UNAME/app
WORKDIR /home/$UNAME/app

# Set the entry point for running the Java application
# CMD ["java", "-jar", "your-java-application.jar"]
# CMD ["sh"]
# To keep the container running even after the shell session is closed, you can modify the CMD line in the Dockerfile as follows:
CMD ["sh", "-c", "tail -f /dev/null"]
# To keep the container running and also rterun the cursor use below CMD,
# CMD ["sh", "-c", "exec sh -i"]