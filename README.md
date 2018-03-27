# Raspberry Pi MJPEG Streamer

Docker container for the Raspberry Pi camera-specific fork of MJPEG Streamer
from: https://github.com/jacksonliam/mjpg-streamer  Pull this from Docker hub
under the **[tdicola/pi_mjpeg_streamer](https://hub.docker.com/r/tdicola/pi_mjpeg_streamer/)** name.

This allows you to easily stream video from the Pi camera to other machines
and process it as a simple MJPEG video stream.  Will expose the MJPEG stream
web output on port 8080.  Make sure to run with the `--privileged` flag to
ensure MJPEG streamer can access the Pi camera hardware!
