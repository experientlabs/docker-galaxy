# Image used on ec2 box, ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-20210223
FROM python:3.7.11

ENV PYTHONBUFFERED=1

RUN apt-get update && \
DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC apt-get install -y netcat ssh iputils-ping sudo python3-pip default-jdk && \
mkdir /var/run/sshd && \
chmod 0755 /var/run/sshd && \
ssh-keygen -A && \
useradd -p $(openssl passwd ex2pwd) --create-home --shell /bin/bash --groups sudo ex2


RUN mkdir -p /var/lib/my-python
RUN chown -R ex2 /var/lib/my-python
RUN service ssh start

ARG MY_JOB_ENVIRONMENT=${MY_JOB_ENVIRONMENT}
ARG SAVE_TEMP_TABLES=${SAVE_TEMP_TABLES}
ARG MY_SNOWFLAKE_WAREHOUSE_OVERRIDE=${MY_SNOWFLAKE_WAREHOUSE_OVERRIDE}
ARG MY_SNOWFLAKE_DATABASE_OVERRIDE=${MY_SNOWFLAKE_DATABASE_OVERRIDE}
ARG AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID}
ARG AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY}
ARG AWS_SESSION_TOKEN=${AWS_SESSION_TOKEN}
ARG AWS_CLI_DOWNLOAD_PATH=${AWS_CLI_DOWNLOAD_PATH}
ARG S3_TO_DATAWAREHOUSE_JAR=${S3_TO_DATAWAREHOUSE_JAR}


USER ex2
RUN mkdir -p /home/ex2/environments
RUN mkdir /home/ex2/.ssh && chmod 700 /home/ex2/.ssh
RUN echo "export MY_JOB_ENVIRONMENT=$MY_JOB_ENVIRONMENT" > /home/ex2/.bash_profile && \
    echo "export MY_SNOWFLAKE_WAREHOUSE_OVERRIDE=$MY_SNOWFLAKE_WAREHOUSE_OVERRIDE" > /home/ex2/.bash_profile && \
    echo "export MY_SNOWFLAKE_DATABASE_OVERRIDE=$MY_SNOWFLAKE_DATABASE_OVERRIDE" > /home/ex2/.bash_profile && \
    echo "export AWS_REGION=us-east-1" > /home/ex2/.bash_profile && \
    echo "export SAVE_TEMP_TABLES=$SAVE_TEMP_TABLES" > /home/ex2/.bash_profile && \
    mkdir -p /home/ex2/.aws && \
    echo "[default]" >> /home/ex2/.aws/credentials && \
    echo "AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID" > /home/ex2/.aws/credentials && \
    echo "AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY" > /home/ex2/.aws/credentials && \
    echo "AWS_SESSION_TOKEN=$AWS_SESSION_TOKEN" > /home/ex2/.aws/credentials && \

COPY setup.py /home/ex2/environments
COPY /var/lib/my-python/etl-code/rquirements.txt /home/ex2/environments
COPY aws_config /home/ex2/.aws/config
COPY --chown=ex2:ex2 id_rsa.pub /home/ex2/.ssh/authorized_keys
RUN chmod 600 /home/ex2/.ssh/authorized_keys && \
    pip3 install virtualenv && \
    /home/ex2/.local/bin/virtualenv /home/ex2/environments/my-virtualenv-python37 && \
    . /home/ex2/environments/my-virtualenv-python37/bin/activate && \
    pip3 install /home/ex2/environments/requirements.txt

USER root
EXPOSE 22
CMD["/usr/sbin/sshd", "-D"]
