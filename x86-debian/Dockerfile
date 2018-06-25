# gmusicapi-scripts for x86
FROM debian:stretch

# Update packages and install software
RUN apt-get update \
    && apt-get -y upgrade \
    && apt-get -y install python3 python3-pip python3-dev libav-tools libmp3lame0 libavcodec57

# You must mount /opt/vc/lib from the native raspbian OS into the container for libavcodec57 to work properly:
# -v /opt/vc/lib:/opt/vc/lib

ENV LD_LIBRARY_PATH /opt/vc/lib

RUN pip3 install gmusicapi \
    && pip3 install gmusicapi-wrapper \
    && pip3 install docopt \
    && pip3 install mutagen \
    && pip3 install gmusicapi-scripts

RUN useradd -ms /bin/bash --home-dir /home/gmuser --create-home -u 1000 gmuser
