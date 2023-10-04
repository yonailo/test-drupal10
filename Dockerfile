FROM drupal:10-apache

WORKDIR /opt/drupal

# Adds SSH to be able to log with vscode
RUN apt-get update && apt-get install ssh -y
RUN echo "root:root" | chpasswd
RUN echo "PermitRootLogin yes" >> /etc/ssh/sshd_config

# This will customize the original Druapal image with
# some composer packages
RUN composer require 'drupal/admin_toolbar:^3.4'

# Relauch original image + ssh service 
ADD bootstrap.sh /tmp/bootstrap.sh
ENTRYPOINT ["/bin/sh","-c"]
CMD ["/tmp/bootstrap.sh"]
