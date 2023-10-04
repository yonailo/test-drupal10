# DRUPAL TEST

This repository uses a docker-compose file which sets up a Drupal 10 container + a Mysql container.

The docker-compose file uses 2 binds, one for installing the mysql database and another one which
mounts the local folder "custom" into the Drupal container at /var/www/html/web/modules/custom

The custom module provides a controller for the homepage, which shows a listing of articles displayed
with the article's view mode "teaser".

The custom theme is based in stable, generated with the [starterkit theming tool](https://www.drupal.org/docs/core-modules-and-themes/core-themes/starterkit-theme)
The theme uses SASS. For compiling the SCSS files, use 

```
compass compile --force
```

# RUNNING THE TEST

$> docker-composer up -d

Open a browser and go to http://localhost:8080/

