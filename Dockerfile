FROM debian:8.0

RUN apt-get -y update && \
apt-get -y install git libmysqlclient-dev graphviz \
python-pip python-dev libyaml-dev

RUN git clone http://github.com/pinterest/pinball.git /pinball.git
WORKDIR /pinball.git
RUN python setup.py install

VOLUME /mnt
RUN cp -r /pinball.git/tutorial /mnt
WORKDIR /mnt
RUN cp /pinball.git/tutorial/example_repo/tutorial.yaml ./tutorial
ADD tutorial.yaml /mnt/config.yaml

EXPOSE 8080 9090

RUN mkdir /pinball
ADD start /pinball/start

ENTRYPOINT ["/pinball/start"]
