FROM openjdk:8

ENV GRADLE_HOME="/opt/gradle"
ENV GRADLE_VERSION="6.5.1"
ENV PATH="${GRADLE_HOME}/bin:${PATH}"

ENV SPARK_HOME="/opt/spark"
ENV SPARK_VERSION="3.0.0"
ENV HADOOP_VERSION="3.2"
ENV PATH="${SPARK_HOME}/bin:${PATH}"

ENV PYTHON3_VERSION="3.8.2"

ENV GCP_PROJECT_ID="bstars-analytics"

WORKDIR /opt

# GRADLE
ADD "https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip" .
RUN unzip -q gradle*.zip && rm -f gradle*.zip && mv gradle* gradle

# Spark
ADD "https://archive.apache.org/dist/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz" .
RUN tar -xzf spark*.tgz && rm -f spark*.tgz && mv spark* spark

# Python 3
RUN apt-get update -qq && apt-get install -qqy python3 python3-pip

# GCloud
RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] http://packages.cloud.google.com/apt cloud-sdk main" \
    | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list \
    && curl https://packages.cloud.google.com/apt/doc/apt-key.gpg \
    | apt-key --keyring /usr/share/keyrings/cloud.google.gpg  add - \
    && apt-get update -y \
    && apt-get install -y google-cloud-sdk

# Adding GCloud Service Account Key
ADD devops/target/*-key.json .
RUN gcloud auth activate-service-account --key-file $(basename *-key.json)
RUN gcloud config set project $GCP_PROJECT_ID

CMD tail -f /dev/null
