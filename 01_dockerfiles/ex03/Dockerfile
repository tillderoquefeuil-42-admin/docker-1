FROM debian

ARG VM_IP=192.168.99.100

# APT UPDATE
RUN apt-get update
RUN apt-get upgrade -y

# APT INSTALL
RUN apt-get install -y nano
RUN apt-get install -y curl openssh-server ca-certificates postfix

# DOWNLOAD GITLAB
RUN curl https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.deb.sh | bash
RUN apt-get install -y gitlab-ce

# GITLAB
RUN rm /etc/gitlab/gitlab.rb
RUN echo "external_url 'http://$VM_IP'" > /etc/gitlab/gitlab.rb

# TO DO IN ENTRYPOINT

# RUN (/opt/gitlab/embedded/bin/runsvdir-start &) && sleep 1 && gitlab-ctl reconfigure


ENTRYPOINT bash