FROM debian:stable-slim

LABEL maintainer="Experient Labs <experientlabs7@gmail.com>"


RUN apt-get -y update
# Upgrade already installed packages:
RUN apt-get -y upgrade

# Install Python 3 and pip
RUN apt-get install -y python3 python3-pip

# Set Python 3 as the default Python version
RUN ln -s /usr/bin/python3 /usr/bin/python

# Verify Python and pip installation
RUN python --version && pip3 --version

RUN apt-get update --yes && \
    apt-get install --yes --no-install-recommends \
    ca-certificates curl zip unzip vim sudo && \
    apt-get clean && rm -rf /var/lib/apt/lists/*


COPY bin/entrypoint.sh /root

############################################
# create group and user
############################################

ARG UNAME=sam
ARG UID=1000
ARG GID=1000

RUN cat /etc/passwd

# create group
RUN groupadd -g $GID $UNAME

# create a user with userid 1000 and gid 100
RUN useradd -u $UID -g $GID -m -s /bin/bash $UNAME
# -m creates home directory

# change permissions of /home/sam to 1000:100
RUN chown $UID:$GID /home/sam

# give sudo access to the user sam NOPASSWD means sudo access without password
# this is not recommended for production application. Excercise caution.
RUN echo "$UNAME ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers


###########################################
# change working dir and user
###########################################

USER $UNAME

# Set the working directory
RUN mkdir -p /home/$UNAME/app
WORKDIR /home/$UNAME/app

# Start a shell session when the container runs
# CMD ["/bin/bash"]

# Use a non-blocking command to keep the container running
CMD ["tail", "-f", "/dev/null"]