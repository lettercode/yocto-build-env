FROM ubuntu:20.04

# Update the system
RUN apt-get update && apt-get -y upgrade

# Install sudo
RUN apt-get -y install sudo

# Version control
RUN apt-get -y install git

# Yocto dependecies
RUN apt-get -y install build-essential
RUN apt-get -y install chrpath cpio diffstat gawk wget
RUN apt-get -y install python3 python3-pip

# Use bash as default shell
RUN rm /bin/sh && ln -s bash /bin/sh

# Locales
RUN apt-get -yq install locales apt-utils sudo && dpkg-reconfigure locales
RUN locale-gen en_US.UTF-8 && update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
ENV LANG en_US.utf8
