FROM node

MAINTAINER Rohscx <emailaddress.com>
# Update node:latest
RUN apt-get update
RUN apt-get install git-core

# Pull Git Image
# Clone Repo
# Change to Root Directory
# Main NPM install
# Change to Sub Directory
# Sub NPM install
RUN cd /home \
  && git clone https://github.com/rohscx/networkInfo.git \
  && cd /home/networkInfo \
  && npm install \
  && cd lib/nodeUtilz \
  && npm install \
  && ls \
  && ls /home \
  && ls /home/lib

# Make a user a non admin user at some point
#RUN echo sleep 30 > /etc/rc.local
#RUN echo service tftpd-hpa restart > /etc/rc.local


# Run Entrypoint script
COPY docker-entrypoint.sh /docker-entrypoint.sh
ENTRYPOINT [ "/docker-entrypoint.sh" ]
RUN chmod 755 /docker-entrypoint.sh
CMD [ "-s" ]

# Set Docker default user and  working directory
WORKDIR /home/networkInfo

EXPOSE  3000/tcp
