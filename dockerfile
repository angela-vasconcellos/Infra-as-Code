####DOCKERFILE SQL#####

FROM mysql:8.0

ARG ROOT_PASSWORD=admin
ENV MYSQL_ROOT_PASSWORD=${ROOT_PASSWORD}

ARG SETUP_REMOTE_USERNAME= ***
ARG SETUP_REMOVE_PASSWORD= ***

ADD script.sql /docker-entrypoint-initdb.d

EXPOSE 3306

CMD ["mysqld"]

####DOCKERFILE APIS#####

FROM python:3
COPY app_cat.py config.py validacao.py componentes.txt /
RUN pip install -r componentes.txt
RUN apt-get update && apt-get install -y apache2
EXPOSE 5002
CMD ["python3", "app_cat.py"]

FROM python:3
COPY app.py config.py validacao.py componentes.txt /
RUN pip install -r componentes.txt
RUN apt-get update && apt-get install -y apache2
EXPOSE 5000
CMD ["python3", "app.py"]


FROM python:3
COPY endereco.py config_end.py componentes.txt /
RUN pip install -r componentes.txt
RUN apt-get update && apt-get install -y apache2
EXPOSE 5001
CMD ["python3", "endereco.py"]

FROM python:3
COPY app_hist.py config.py componentes.txt /
RUN pip install -r componentes.txt
RUN apt-get update && apt-get install -y apache2
EXPOSE 5003
CMD ["python3", "app_hist.py"]
