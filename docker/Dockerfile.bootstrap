
# docker really doesn't want to run systemd. so it's not clear how well this works
# start sshd from bash like this,
# /usr/sbin/sshd -D

FROM debian:stretch

RUN apt-get update

RUN apt-get -y install ansible

# help ansible, by lockin in some dependenies
RUN apt-get -y install vim less
RUN apt-get -y install locales
RUN apt-get -y install aptitude
RUN apt-get -y install ssh

# env
ENV       w /root
ENV       a $w/ansible-consolidated

#inventory  plays  roles  scripts  ansible.cfg  credentials.yml

RUN mkdir $a
COPY roles $a/roles
COPY plays $a/plays
COPY ansible.cfg $a/ansible.cfg
# careful, will bake into the image
COPY credentials.yml $a/credentials.yml

RUN cd $a && ansible-playbook plays/personal/bootstrap.yml -i localhost, -c local

WORKDIR   $w

