FROM java:8-alpine

ARG PAPER_JOB=Paper-1.13
ARG PAPER_URL=https://destroystokyo.com/ci/job/${PAPER_JOB}/lastSuccessfulBuild/artifact/paperclip.jar

EXPOSE 25565

WORKDIR /data
ADD "${PAPER_URL}" /srv/paperclip.jar
RUN cd /srv &&\
	java -jar paperclip.jar &&\
	mv cache/patched*.jar paper.jar &&\
	rm -rf cache &&\
	chmod 444 /srv/paper.jar

ADD start.sh /usr/local/bin/paper
RUN chmod +x /usr/local/bin/paper

ENV JAVA_ARGS "-Xmx1G"
ENV SPIGOT_ARGS ""
ENV PAPER_ARGS ""

VOLUME "/data"

CMD ["paper"]
