FROM drupal:10-apache

WORKDIR /opt/drupal

# Adds SSH to be able to log with vscode and other
# debian packages
RUN apt-get update && apt-get install -y ssh vim less telnet build-essential ruby-full compass

# Remove Apache2 error log because it is redirected to stderr
RUN rm /var/log/apache2/error.log

# Sets very low opcache.revalidate_freq to not cache php files
RUN echo "opcache.revalidate_freq=1" >> /usr/local/etc/php/conf.d/opcache-recommended.ini

# Enable ssh with user root, password root
RUN echo "root:root" | chpasswd
RUN echo "PermitRootLogin yes" >> /etc/ssh/sshd_config

# This will customize the original Drupal image with
# some composer packages
RUN composer require 'drupal/admin_toolbar:^3.4'

# Relauch original image + ssh service 
ADD bootstrap.sh /tmp/bootstrap.sh
ENTRYPOINT ["/bin/sh","-c"]
CMD ["/tmp/bootstrap.sh"]
