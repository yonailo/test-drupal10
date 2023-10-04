FROM drupal:10-apache

WORKDIR /opt/drupal

# This will customize the original Druapal image with
# some composer packages
RUN composer require 'drupal/admin_toolbar:^3.4'
