FROM		ubuntu:14.04.2
MAINTAINER	Daniel Boline <ddboline@gmail.com>

# ADD sudoers /etc/sudoers
RUN export uid=1000 gid=1000 && \
    mkdir -p /home/ubuntu && \
    mkdir -p /etc/sudoers.d && \
    echo "ubuntu:x:${uid}:${gid}:Developer,,,:/home/ubuntu:/bin/bash" >> /etc/passwd && \
    echo "ubuntu:x:${uid}:" >> /etc/group && \
    echo "ubuntu ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/ubuntu && \
    chmod 0440 /etc/sudoers.d/ubuntu && \
    chown ${uid}:${gid} -R /home/ubuntu

USER ubuntu
ENV USER ubuntu
ENV HOME /home/ubuntu
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en

ADD     run_testing.sh /home/ubuntu/run_testing.sh
ADD     run_testing_ssh.sh /home/ubuntu/run_testing_ssh.sh
ADD     run_testing_local.sh /home/ubuntu/run_testing_local.sh
ADD     run_testing_conda.sh /home/ubuntu/run_testing_conda.sh
ADD     run_testing_local_conda.sh /home/ubuntu/run_testing_local_conda.sh
ADD     run_testing_local.sh /home/ubuntu/run_testing_local.sh
ADD     run_testing_ssh_conda.sh /home/ubuntu/run_testing_ssh_conda.sh
ADD     keys_20150119.tar.gz /home/ubuntu/

RUN sudo chown ubuntu:ubuntu -R /home/ubuntu/
