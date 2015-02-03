### test dockerfile
FROM		ubuntu:14.04.1
MAINTAINER	Daniel Boline <ddboline@gmail.com>
RUN		apt-get update && apt-get install -y git python2.7
ADD     run_testing.sh /root/run_testing.sh
ADD     run_testing_ssh.sh /root/run_testing_ssh.sh
