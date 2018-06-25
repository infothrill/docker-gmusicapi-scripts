# gmusicapi-scripts for armhf
FROM monstrenyatko/rpi-alpine:3.7 as compile

# Update packages and install software
RUN apk -U update && \
        apk -U add --no-cache \
            python3 \
            python3-dev \
            gcc \
            musl-dev \
            py3-virtualenv

RUN pyvenv /virtual
RUN ls -l /virtual/bin/
RUN /bin/sh -c "source /virtual/bin/activate && pip3 install mutagen && deactivate"
RUN ls -l /virtual/bin/
RUN /bin/sh -c "source /virtual/bin/activate && pip3 install docopt && deactivate"

RUN apk -U update && \
    apk -U add --no-cache \
        libxslt-dev

RUN /bin/sh -c "source /virtual/bin/activate && pip3 install pycryptodomex && deactivate"
RUN /bin/sh -c "source /virtual/bin/activate && pip3 install gmusicapi && deactivate"
RUN /bin/sh -c "source /virtual/bin/activate && pip3 install gmusicapi-wrapper && deactivate"
RUN /bin/sh -c "source /virtual/bin/activate && pip3 install gmusicapi-scripts && deactivate"
RUN ls -l /virtual/bin/

# Main image
FROM monstrenyatko/rpi-alpine:3.7
RUN apk -U update && \
        apk -U add --no-cache \
            ffmpeg \
            python3

RUN adduser -S -u 1000 -h /home/gmuser -s /bin/sh gmuser
COPY --from=compile /virtual /virtual
