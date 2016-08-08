FROM ubuntu:16.04
MAINTAINER Zhongdi Wang <wangmuy@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

# Bash instead of Dash
RUN echo "dash dash/sh boolean false" | debconf-set-selections && \
    dpkg-reconfigure -p critical dash

# apt using ustc mirror
COPY sources.ustc.list /etc/apt/sources.list

RUN apt-get update

# workaround for make 3.81/3.82
RUN apt-get install -y wget && \
    wget http://mirrors.ustc.edu.cn/ubuntu/pool/main/m/make-dfsg/make_3.81-8.2ubuntu3_amd64.deb -O /tmp/make.deb && \
    dpkg -i /tmp/make.deb

RUN apt-get install -y git gnupg flex bison gperf build-essential\
    zip curl zlib1g-dev gcc-multilib g++-multilib libc6-dev-i386 \
    libncurses5-dev x11proto-core-dev libx11-dev lib32z-dev ccache \
    libgl1-mesa-dev libxml2-utils xsltproc unzip python \
    vim subversion dos2unix bc expect && \
    apt-get install -y software-properties-common && add-apt-repository -y ppa:openjdk-r/ppa && apt-get update && apt-get install -y --allow-unauthenticated openjdk-7-jdk
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*