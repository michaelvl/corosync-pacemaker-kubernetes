FROM ubuntu:18.04

RUN apt-get update && apt-get install -y corosync pacemaker
ADD scripts/start.sh /start.sh

CMD [ "/start.sh"]
