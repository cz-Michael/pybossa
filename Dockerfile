FROM ubuntu:16.04

RUN apt-get update

# Git
RUN apt-get install -y git-core

# PostgreSQL
RUN apt-get install -y postgresql postgresql-server-dev-all libpq-dev python-psycopg2 libsasl2-dev libldap2-dev libssl-dev

# Redis
# RUN apt-get install -y redis-server

# Python virtualenv (optional)
RUN apt-get install -y python-virtualenv

# Python requirements
RUN apt-get install -y python python-pip python-dev build-essential libjpeg-dev libssl-dev libffi-dev
RUN apt-get install -y dbus libdbus-1-dev libdbus-glib-1-dev libldap2-dev libsasl2-dev

# Upgrade pip to latest version
RUN pip install -U pip

# Workaround for bug in PyCParser
RUN pip install git+https://github.com/eliben/pycparser@release_v2.14

# Add code
ADD . /pybossa
WORKDIR /pybossa

# Install the required libraries
RUN pip install -U -r requirements.txt

# Populate the database
# RUN python cli.py db_create

EXPOSE 5000

# CMD ["tail", "-f", "/dev/null"]

CMD ["python", "run.py"]
