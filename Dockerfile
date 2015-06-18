FROM		ubuntu:14.04.2
MAINTAINER	Daniel Boline <ddboline@gmail.com>

RUN apt-get update && apt-get install -y git
RUN mkdir -p /home/ubuntu
ADD     run_testing.sh /home/ubuntu/run_testing.sh
ADD     run_testing_ssh.sh /home/ubuntu/run_testing_ssh.sh
ADD     run_testing_local.sh /home/ubuntu/run_testing_local.sh
ADD     run_testing_conda.sh /home/ubuntu/run_testing_conda.sh
ADD     run_testing_local_conda.sh /home/ubuntu/run_testing_local_conda.sh
ADD     run_testing_local.sh /home/ubuntu/run_testing_local.sh
ADD     run_testing_ssh_conda.sh /home/ubuntu/run_testing_ssh_conda.sh
ADD     keys_20150617.tar.gz /home/ubuntu/
ADD     keys_20150617.tar.gz /root/

RUN cp -a /home/ubuntu/.ssh /root/ && chown -R root:root /root

RUN export uid=1000 gid=1000 && \
    mkdir -p /etc/sudoers.d && \
    echo "ubuntu:x:${uid}:${gid}:Developer,,,:/home/ubuntu:/bin/bash" >> /etc/passwd && \
    echo "ubuntu:x:${uid}:" >> /etc/group && \
    echo "ubuntu ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/ubuntu && \
    chmod 0440 /etc/sudoers.d/ubuntu && \
    git clone https://github.com/ddboline/docker_scripts.git /home/ubuntu/docker_scripts && \
    chown ${uid}:${gid} -R /home/ubuntu

USER ubuntu
ENV USER ubuntu
ENV HOME /home/ubuntu
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
