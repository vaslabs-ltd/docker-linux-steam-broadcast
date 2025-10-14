FROM linuxserver/ffmpeg:latest

RUN apt-get update && apt-get install -y bc

WORKDIR /videos
COPY start.sh /start.sh
ENTRYPOINT ["/bin/bash", "/start.sh"]