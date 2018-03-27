# Docker container for the Raspberry Pi camera-specific fork of MJPEG Streamer
# from: https://github.com/jacksonliam/mjpg-streamer
# This allows you to easily stream video from the Pi camera to other machines
# and process it as a simple MJPEG video stream.  Will expose the MJPEG stream
# web output on port 8080.
#
# Author: Tony DiCola
FROM resin/rpi-raspbian:stretch

# Informative labels.
LABEL description="Docker container for the Raspberry Pi-specific fork of MJPEG Streamer from: https://github.com/jacksonliam/mjpg-streamer"
LABEL maintainer="tony@tonydicola.com"

# Install dependencies.
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    git \
    libjpeg8-dev \
    libraspberrypi-dev \
  && rm -rf /var/lib/apt/lists/*

# Get mjpg-streamer fork code and build it.
WORKDIR /
RUN git clone https://github.com/jacksonliam/mjpg-streamer.git
WORKDIR /mjpg-streamer/mjpg-streamer-experimental
RUN make && make install && chmod +x docker-start.sh

# Expose HTTP 8080 for MJPG stream, then setup an entrypoint that runs the
# mjpeg streamer with its raspberry pi input plugin.  Note that you MUST run
# this in a privileged docker container (use --privileged with docker run).
EXPOSE 8080/TCP
ENTRYPOINT ["/mjpg-streamer/mjpg-streamer-experimental/docker-start.sh", "output_http.so -w ./www"]
CMD ["input_raspicam.so"]
