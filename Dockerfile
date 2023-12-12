﻿FROM rclone/rclone:latest
WORKDIR /
ADD https://github.com/itsToggle/plex_debrid/archive/refs/heads/main.zip /
ADD . / ./
ADD https://raw.githubusercontent.com/debridmediamanager/zurg-testing/main/config.yml /zurg/
ENV \
  XDG_CONFIG_HOME=/config \
  TERM=xterm 
RUN \
  apk add --update --no-cache gcompat libstdc++ libxml2-utils curl tzdata nano ca-certificates wget fuse3 python3 build-base py3-pip python3-dev py3-dotenv py3-schedule py3-psutil && ln -sf python3 /usr/bin/python && \
  unzip main.zip && rm main.zip && \
  mv plex_debrid-main/ plex_debrid && \   
  pip3 install -r /plex_debrid/requirements.txt && \
  pip3 install -r /requirements.txt 
HEALTHCHECK --interval=60s --timeout=10s \
  CMD python /healthcheck.py  
ENTRYPOINT ["python", "/main.py"]