FROM phusion/baseimage:0.9.16

MAINTAINER Michael Keirnan <michael@keirnan.com>

ENV HOME /root
RUN /etc/my_init.d/00_regen_ssh_host_keys.sh
CMD ["/sbin/my_init"]

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && \
    apt-get install -y \
      build-essential \
      bzip2 \
      gcc \
      gfortran \
      python-qt4 \
      wget; \
    apt-get clean; \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV MINI_INSTALLER Miniconda3-3.9.1-Linux-x86_64.sh
RUN \
  wget --quiet \
  http://repo.continuum.io/miniconda/$MINI_INSTALLER && \
  /bin/bash /$MINI_INSTALLER -b -p /opt/anaconda && \
  rm $MINI_INSTALLER

RUN echo 'export PATH=/opt/anaconda/bin:$PATH' > /etc/profile.d/conda.sh
ENV PATH /opt/anaconda/bin:$PATH

RUN \
  conda update --yes conda && conda install --yes \
    dateutil \
    matplotlib \
    numpy \
    pip \
    pytables \
    scipy

RUN pip install pandas==0.16.0

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
