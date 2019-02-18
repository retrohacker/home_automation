FROM debian

RUN apt-get update \
 && apt-get install -y curl gnupg2 \
 && curl https://archive.raspberrypi.org/debian/raspberrypi.gpg.key \
  | apt-key add - \
 && echo 'deb http://archive.raspberrypi.org/debian/ stretch main ui' \
  > /etc/apt/sources.list.d/raspi.list \
 && apt-get update \
 && apt-get install -y libraspberrypi0

RUN curl -L -o motion.deb https://github.com/Motion-Project/motion/releases/download/release-4.2.2/pi_stretch_motion_4.2.2-1_armhf.deb

RUN apt-get install -y ffmpeg gdebi \
 && gdebi --n motion.deb

CMD ["motion", "-c", "/config/motion.conf"]

RUN apt-get upgrade -y
