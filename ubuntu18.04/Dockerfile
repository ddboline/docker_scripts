FROM		ubuntu:bionic
MAINTAINER	Daniel Boline <ddboline@gmail.com>

RUN mkdir -p /home/ddboline
COPY    run_testing.sh /home/ddboline/run_testing.sh
COPY    run_testing_python3.sh /home/ddboline/run_testing_python3.sh
COPY    run_testing_conda.sh /home/ddboline/run_testing_conda.sh
COPY    run_testing_ssh.sh /home/ddboline/run_testing_ssh.sh
COPY    run_testing_ssh_python3.sh /home/ddboline/run_testing_ssh_python3.sh
COPY    run_testing_ssh_conda.sh /home/ddboline/run_testing_ssh_conda.sh
COPY    run_testing_local.sh /home/ddboline/run_testing_local.sh
COPY    run_testing_local_conda.sh /home/ddboline/run_testing_local_conda.sh
COPY    run_testing_local_python3.sh /home/ddboline/run_testing_local_python3.sh
ADD     keys_20161201.tar.gz /home/ddboline/
ADD     keys_20161201.tar.gz /root/

RUN apt-get update && apt-get dist-upgrade -y
RUN apt-get install -y git sudo python-minimal gnupg2
RUN apt-key add /root/ddboline_711C1DEB.gpg
RUN chown -R root:root /root

RUN export uid=1000 gid=1000 && \
    mkdir -p /etc/sudoers.d && \
    echo "ddboline:x:${uid}:${gid}:Developer,,,:/home/ddboline:/bin/bash" >> /etc/passwd && \
    echo "ddboline:x:${uid}:" >> /etc/group && \
    echo "ddboline ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/ddboline && \
    chmod 0440 /etc/sudoers.d/ddboline && \
    git clone https://github.com/ddboline/docker_scripts.git /home/ddboline/docker_scripts && \
    chown ${uid}:${gid} -R /home/ddboline

USER ddboline
ENV USER ddboline
ENV HOME /home/ddboline
ENV LANG C.UTF-8
ENV LANGUAGE en_US:en
