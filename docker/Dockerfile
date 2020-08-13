FROM debian:10

# Update the system
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get clean && apt-get update && apt-get -y upgrade

# Locales
RUN apt-get -y install locales apt-utils
RUN echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
RUN locale-gen && dpkg-reconfigure locales
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8
RUN update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8

# Install sudo
RUN apt-get -y install sudo

# Version control
RUN apt-get -y install git subversion

# Yocto dependecies
RUN apt-get -y install build-essential gcc-multilib g++-multilib
RUN apt-get -y install chrpath cpio diffstat gawk wget curl
RUN apt-get -y install python python3 python3-pip

# Wic dependencies (wic ls)
RUN apt-get -y install parted mtools

# Utilities
RUN apt-get -y install texinfo nano

# Use bash as default shell
RUN rm /bin/sh && ln -s bash /bin/sh

# Clean up filesystem
RUN apt-get clean && rm -rf /var/lib/apt/lists/*
RUN rm -rf /tmp/* /var/tmp/*

# Create the work dir
ARG workdir
RUN test -n "${workdir}"
RUN mkdir -p "${workdir}"
WORKDIR "$workdir"

# Create the build user
ARG gid
RUN test -n "${gid}"
ARG uid
RUN test -n "${uid}"
ARG username
RUN test -n "${username}"
RUN groupadd -g ${gid} ${username}
RUN useradd --password U6aMy0wojraho --shell /bin/bash --key UID_MIN=${uid} --key GID_MIN=${gid} --uid $uid --gid $gid --no-create-home --home-dir /home/$username $username
RUN usermod -aG sudo $username
RUN usermod -aG users $username
USER $username
