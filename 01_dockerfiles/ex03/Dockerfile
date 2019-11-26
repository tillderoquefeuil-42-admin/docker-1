# /!\ add 'GIT_SSL_NO_VERIFY=true' before each git clone/push cmd with https repo /!\

FROM debian

ARG VM_IP=192.168.99.100
ENV ENV_VM_IP=$VM_IP
ENV SSH_PASSPHRASE 'passphrase'

# APT UPDATE
RUN apt-get update
RUN apt-get upgrade -y

# SET ROOT PASSWORD
RUN echo "root:root" | chpasswd

# APT INSTALL
RUN apt-get install -y curl openssh-server ca-certificates postfix
RUN apt-get install -y nano git

# DOWNLOAD GITLAB
RUN curl https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.deb.sh | bash
RUN apt-get install -y gitlab-ce

# SSL
RUN mkdir -p /etc/gitlab/ssl
RUN openssl req -new -x509 -days 365 -nodes \
	-subj /C=FR/ST=75/L=Paris/O=rs1/OU=rs1/CN=$ENV_VM_IP/emailAddress=tde-roqu@student.42.fr \
    -keyout /etc/gitlab/ssl/selfsigned.key \
    -out /etc/gitlab/ssl/selfsigned.crt

# SSH
RUN ssh-keygen -N $SSH_PASSPHRASE -f /root/.ssh/id_rsa

# GITLAB CONFIGURATION
RUN rm /etc/gitlab/gitlab.rb
RUN echo "external_url 'https://$ENV_VM_IP'" > /etc/gitlab/gitlab.rb
RUN echo "grafana['enable'] = false" >> /etc/gitlab/gitlab.rb
RUN echo "nginx['redirect_http_to_https'] = true" >> /etc/gitlab/gitlab.rb
RUN echo "nginx['ssl_certificate'] = \"/etc/gitlab/ssl/selfsigned.crt\"" >> /etc/gitlab/gitlab.rb
RUN echo "nginx['ssl_certificate_key'] = \"/etc/gitlab/ssl/selfsigned.key\"" >> /etc/gitlab/gitlab.rb
RUN echo "gitlab_rails['gitlab_shell_ssh_port'] = 8022" >> /etc/gitlab/gitlab.rb

ENTRYPOINT service ssh start \
    && (/opt/gitlab/embedded/bin/runsvdir-start &) \
    && sleep 1 \
    && gitlab-ctl reconfigure \
    && echo "\n\nThe app is now running on https://$ENV_VM_IP\n\n" \
    && tail -f /dev/null