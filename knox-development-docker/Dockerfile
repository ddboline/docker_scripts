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

# Installs our dependencies
#RUN apt-get update
#RUN apt-get install -y python3-pip openjdk-8-jdk wget

# Adds in a new user and its home environment
#RUN useradd knox

# Installs scala and spark
#RUN /knox/bin/docker_bootstrap

# RUN sudo pip3 install ipython sqlparse \
#     pycodestyle pyflakes yapf==0.22.0 pytest pytest-cov \
#     numpy pandas fastavro mock cpplint confluent-kafka[avro] \
#     psutil virtualenv

# Copy the current directory contents into the container at /app
# ADD bin /fpg/bin
# ADD conf/spark-defaults.conf ${SPARK_HOME}/conf/spark-defaults.conf
# ADD setup.py /fpg/setup.py
# ADD fpg /fpg/fpg
# ADD lib /fpg/lib
# ADD scripts /fpg/scripts
# ADD tests /fpg/tests
# ADD requirements-lambda.txt /fpg/requirements-lambda.txt
# 
# RUN sudo chown -R fpg:fpg /fpg
# RUN sudo chmod a+x /fpg/fpg/bin/fpgapi
# 
# RUN cd lib/fee_instruction_test/ && make clean && make && make install
# 
# # Installs FPGv3
# RUN sudo pip3 install /fpg

CMD ["/bin/bash"]
