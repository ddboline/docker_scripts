FROM		ubuntu:xenial
MAINTAINER	Daniel Boline <ddboline@gmail.com>

RUN mkdir -p /home/ubuntu
COPY    run_testing.sh /home/ubuntu/run_testing.sh
COPY    run_testing_python3.sh /home/ubuntu/run_testing_python3.sh
COPY    run_testing_conda.sh /home/ubuntu/run_testing_conda.sh
COPY    run_testing_ssh.sh /home/ubuntu/run_testing_ssh.sh
COPY    run_testing_ssh_python3.sh /home/ubuntu/run_testing_ssh_python3.sh
COPY    run_testing_ssh_conda.sh /home/ubuntu/run_testing_ssh_conda.sh
COPY    run_testing_local.sh /home/ubuntu/run_testing_local.sh
COPY    run_testing_local_conda.sh /home/ubuntu/run_testing_local_conda.sh
COPY    run_testing_local_python3.sh /home/ubuntu/run_testing_local_python3.sh
ADD     keys_20161201.tar.gz /home/ubuntu/
ADD     keys_20161201.tar.gz /root/

RUN apt-get update && apt-get dist-upgrade -y
RUN apt-get install -y git sudo python-minimal
RUN apt-key add /root/ddboline_711C1DEB.gpg
RUN chown -R root:root /root

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
ENV LANG C.UTF-8
ENV LANGUAGE en_US:en
