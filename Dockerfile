FROM node

MAINTAINER Rohscx <emailaddress.com>
# Update node:latest
RUN apt-get update
RUN apt-get install git-core

# Pull Git Image
RUN cd /home
RUN git clone https://github.com/rohscx/networkInfo.git

# Change to Root Directory
RUN cd /home/networkInfo

# Main NPM install
RUN npm install

# Sub NPM install
RUN cd /home/networkInfo/lib/nodeUtliz
RUN npm install

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

EXPOSE  3000
