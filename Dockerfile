### test dockerfile
FROM		ubuntu:14.04.2
MAINTAINER	Daniel Boline <ddboline@gmail.com>
ADD     run_testing.sh /root/run_testing.sh
ADD     run_testing_ssh.sh /root/run_testing_ssh.sh
ADD     run_testing_local.sh /root/run_testing_local.sh
