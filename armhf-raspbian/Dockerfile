# gmusicapi-scripts for raspberry pi / armhf
FROM resin/rpi-raspbian:stretch as compile
# Update packages and install software
RUN apt-get update \
    && apt-get -y install \
        python3 \
        python3-pip \
        python3-dev \
        python3-setuptools \
        python3-wheel \
        python3-virtualenv \
        build-essential \
        libgmp3-dev \
        libxml2-dev \
        libxslt1-dev \
        zlib1g-dev \
    && rm -rf /var/lib/apt/lists/*

RUN apt-get update \
    && apt-get -y install \
        python3-venv \
        python3-lxml \
    && rm -rf /var/lib/apt/lists/*
# we rely on --system-site-packages for lxml
RUN pyvenv /virtual
RUN /bin/sh -c ". /virtual/bin/activate && pip3 install mutagen && deactivate"
RUN /bin/sh -c ". /virtual/bin/activate && pip3 install docopt && deactivate"
RUN /bin/sh -c ". /virtual/bin/activate && pip3 install pycryptodomex && deactivate"
RUN /bin/sh -c ". /virtual/bin/activate && pip3 install gmusicapi && deactivate"
RUN /bin/sh -c ". /virtual/bin/activate && pip3 install gmusicapi-wrapper && deactivate"
RUN /bin/sh -c ". /virtual/bin/activate && pip3 install gmusicapi-scripts && deactivate"

FROM resin/rpi-raspbian:stretch

# Update packages and install software
RUN apt-get update \
    && apt-get -y install \
        python3 \
        libav-tools \
        libmp3lame0 \
        libavcodec57 \
    && rm -rf /var/lib/apt/lists/*

# You must mount /opt/vc/lib from the native raspbian OS into the container for libavcodec57 to work properly:
# -v /opt/vc/lib:/opt/vc/lib

ENV LD_LIBRARY_PATH /opt/vc/lib

RUN useradd -ms /bin/bash --home-dir /home/gmuser --create-home -u 1000 gmuser
COPY --from=compile /virtual /virtual
