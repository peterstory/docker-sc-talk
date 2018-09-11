FROM python:3.6
MAINTAINER pstory@andrew.cmu.edu

# Our dependencies
RUN mkdir /root/django
ADD requirements.txt /root/django/requirements.txt
RUN pip install -r /root/django/requirements.txt
RUN apt-get update && apt-get install -y postgresql-client

ADD demoproject /root/django/demoproject
WORKDIR /root/django/demoproject
ENV PYTHONPATH=/root/djano/demoproject
ENV DJANGO_SETTINGS_MODULE='demoproject.settings'
ADD entrypoint.sh /root/django

CMD ["/root/django/entrypoint.sh"]
