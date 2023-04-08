FROM debian:11

# works on x86
# RUN apt-get update && apt-get install -y gnupg2 wget
# RUN wget -O- http://neuro.debian.net/lists/bullseye.us-tn.full | tee /etc/apt/sources.list.d/neurodebian.sources.list && \
#   apt-key adv --recv-keys --keyserver hkps://keyserver.ubuntu.com 0xA5D32F012649A5A9
# RUN apt-get update && apt-get install -y git git-annex-standalone
RUN echo "deb http://deb.debian.org/debian testing main" >> /etc/apt/sources.list
RUN apt-get update && apt-get install -y git-annex -t testing

RUN adduser --disabled-password --gecos '' developer && echo "developer:pass" | chpasswd
RUN apt-get update && apt-get install -y openssh-server tree duf
RUN mkdir /home/developer/Crypt
RUN mkdir /home/developer/.ssh
RUN echo "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEIA2jCeHDAqaJEfai9hra5W4FMO7iiMq1KZXK3BU81u josh@hoth.local" > /home/developer/.ssh/authorized_keys
RUN chown -R developer:developer /home/developer
RUN mkdir /run/sshd
EXPOSE 2222
CMD ["/usr/sbin/sshd", "-D", "-e", "-p", "2222"]
