FROM fpg/spark_docker:SNAPSHOT
LABEL maintainer="Daniel Boline <dboline@mediamath.com>"

RUN mkdir -p /home/knox

RUN export uid=1000 gid=1000 && \
    mkdir -p /etc/sudoers.d && \
    echo "knox:x:${uid}:${gid}:Developer,,,:/home/knox:/bin/bash" >> /etc/passwd && \
    echo "knox:x:${uid}:" >> /etc/group && \
    echo "knox ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/knox && \
    chmod 0440 /etc/sudoers.d/knox && \
    chown ${uid}:${gid} -R /home/knox

USER knox
ENV USER knox
ENV HOME /home/knox

# Set the working directory to /knox
WORKDIR /knox

# Sets up environmental variables required for spark
ENV PYTHONPATH ${SPARK_HOME}/python/:${PYTHONPATH}
ENV PYSPARK_PYTHON python3
#ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64
ENV PATH /knox/bin:${PATH}

RUN sudo pip3 install ipython sqlparse \
    pycodestyle pyflakes yapf==0.22.0 pytest pytest-cov \
    numpy pandas fastavro mock cpplint psutil boto3

CMD ["/bin/bash"]
