FROM apache/airflow:latest-python3.12
COPY requirements.txt .
RUN pip install -r requirements.txt

COPY ./dags/ dags/
COPY ./plugins/ plugins/

USER root
RUN apt-get update && apt-get install -y nano && apt-get clean
USER airflow

# USER root
# RUN apt update && \
#     apt install -y openjdk-17-jdk && \
#     apt install -y ant && \
#     apt clean;

# ENV JAVA_HOME /usr/lib/jvm/java-17-openjdk-amd64/
# RUN export JAVA_HOME

# RUN apt-get install libgbm1 libxkbcommon0 -y
# USER airflow
# RUN playwright install chromium