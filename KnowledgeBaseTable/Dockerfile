#Specify the version of nodejs.
#FROM buildkite/puppeteer:10.0.0
#FROM dayyass/muse_as_service:1.1.2
# FROM apify/actor-node-puppeteer-chrome:18-20.4.0-beta

# RUN wget http://ftp.us.debian.org/debian/pool/main/y/youtube-dl/youtube-dl_2021.12.17-2_all.deb
# RUN apt-get install -y ./youtube-dl_2021.12.17-2_all.deb

FROM node:14.21.3-bullseye

# RUN cat /etc/apt/sources.list

# RUN sed -i s/deb.debian.org/archive.debian.org/g /etc/apt/sources.list
# RUN sed -i 's|security.debian.org|archive.debian.org/|g' /etc/apt/sources.list
# RUN sed -i '/stretch-updates/d' /etc/apt/sources.list
# # RUN ls /etc/apt/sources.list.d
# RUN rm -rf /etc/apt/sources.list.d/*
# COPY ./sources.list /etc/apt/
# RUN cat /etc/apt/sources.list

# RUN apt-get clean 
# RUN apt update

RUN mkdir -p /app
WORKDIR /app

RUN npm link express 
RUN npm link axios 
RUN npm link xlsx 
RUN npm link body-parser