FROM openjdk:8

ENV GRADLE_HOME="/opt/gradle"
ENV GRADLE_VERSION="6.5.1"
ENV PATH="${GRADLE_HOME}/bin:${PATH}"

ENV SPARK_HOME="/opt/spark"
ENV SPARK_VERSION="3.0.0"
ENV HADOOP_VERSION="2.7"
ENV PATH="${SPARK_HOME}/bin:${PATH}"

ENV PYTHON3_VERSION="3.8.2"

WORKDIR /opt

# GRADLE
ADD "https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip" .
RUN unzip -q gradle*.zip && rm -f gradle*.zip && mv gradle* gradle

# Spark
ADD "https://downloads.apache.org/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz" .
RUN tar -xzf spark*.tgz && rm -f spark*.tgz && mv spark* spark

# Python 3
RUN apt-get update -qq
RUN apt-get install -qqy software-properties-common \
    build-essential \
    zlib1g-dev \
    libncurses5-dev \
    libgdbm-dev \
    libnss3-dev \
    libssl-dev \
    libreadline-dev \
    libffi-dev \
    wget

ADD "https://www.python.org/ftp/python/${PYTHON3_VERSION}/Python-${PYTHON3_VERSION}.tgz" .
RUN tar -xzf Python*.tgz && rm -f Python*.tgz && mv Python* Python
RUN cd Python \
    && ./configure --enable-optimizations > py-configure.log 2>&1 \
    && make install > py-install.log 2>&1 \
    && cd -

CMD tail -f /dev/null
