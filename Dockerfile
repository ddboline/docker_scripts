### test dockerfile
FROM		ubuntu:14.04.2
MAINTAINER	Daniel Boline <ddboline@gmail.com>

RUN export uid=1000 gid=1000 && \
    mkdir -p /home/ubuntu && \
    echo "ubuntu:x:${uid}:${gid}:Developer,,,:/home/ubuntu:/bin/bash" >> /etc/passwd && \
    echo "ubuntu:x:${uid}:" >> /etc/group && \
    echo "ubuntu ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/ubuntu && \
    chmod 0440 /etc/sudoers.d/ubuntu && \
    chown ${uid}:${gid} -R /home/ubuntu

USER ubuntu
ENV HOME /home/ubuntu

ADD     run_testing.sh /home/ubuntu/run_testing.sh
ADD     run_testing_ssh.sh /home/ubuntu/run_testing_ssh.sh
ADD     run_testing_local.sh /home/ubuntu/run_testing_local.sh
ADD     run_testing_conda.sh /home/ubuntu/run_testing_conda.sh
ADD     run_testing_local_conda.sh /home/ubuntu/run_testing_local_conda.sh
ADD     run_testing_local.sh /home/ubuntu/run_testing_local.sh
ADD     run_testing_ssh_conda.sh /home/ubuntu/run_testing_ssh_conda.sh
