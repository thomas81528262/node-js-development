FROM debian:stable-20211011 as install-drone

RUN apt-get update
RUN apt-get -y install curl
RUN curl -L https://github.com/drone/drone-cli/releases/latest/download/drone_linux_amd64.tar.gz | tar zx
RUN install -t /usr/local/bin drone

FROM debian:stable-20211011

# Install packages


RUN apt-get update
RUN apt-get -y install curl
#RUN curl -sL https://deb.nodesource.com/setup_16.x | bash -


RUN apt-get -y install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release \
    openssh-server \
    vim \
    zsh \
    iputils-ping \
    iproute2 \
    net-tools \
    traceroute

#
#
## Install nodejs





#install docker
RUN curl -fsSL https://download.docker.com/linux/debian/gpg |  gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
RUN echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" |  tee /etc/apt/sources.list.d/docker.list > /dev/null
RUN apt-get update && apt-get -y install docker-ce docker-ce-cli containerd.io
#
#



#
## Install zsh
RUN curl -o /root/install.sh -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh
RUN sh /root/install.sh
RUN chsh -s $(which zsh)
RUN mkdir /.nvm
ENV NVM_DIR=/.nvm
RUN curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash
RUN . /.nvm/nvm.sh && nvm install v16.13.2 && nvm install v12.22.10
RUN . /.nvm/nvm.sh && nvm use v16.13.2 && npm install -g release-it nodemon ts-node
#

#
RUN update-alternatives --set iptables /usr/sbin/iptables-legacy
#
RUN curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
RUN chmod +x /usr/local/bin/docker-compose
COPY daemon.json /etc/docker/daemon.json
COPY --from=install-drone /drone /usr/local/bin
#
COPY start.sh /bin/start.sh
RUN chmod 755 /bin/start.sh



ENTRYPOINT ["start.sh"]

EXPOSE 22
CMD []