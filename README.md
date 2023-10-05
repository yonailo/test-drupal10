# DRUPAL TEST

This repository uses a docker-compose file which sets up a Drupal 10 container + a Mysql container.

The docker-compose file uses multiples mount-binds between the containers and the host.

The custom module provides a controller for the homepage, which shows a listing of articles displayed
with the article's view mode "teaser". There is a custom twig template in
'web/themes/custom/themetest/templates/themetest/page--articles--all.html.twig' which adds a wrapper
div which is used for styling in 'sass/styles.scss'

The custom theme is based in Olivero, generated with the [starterkit theming tool](https://www.drupal.org/docs/core-modules-and-themes/core-themes/starterkit-theme)

```
php web/core/scripts/drupal generate-theme themetest --name 'Theme de test' --description "Custom theme generated from Olivero" --starterkit olivero --path=themes/custom
```

The theme uses SASS. For compiling the SCSS files, please use:

```
$> cd themes/custom/themetest
$> compass compile --force (or compass watch)
```

# RUNNING THE TEST

```
$> docker-composer up -d

Open a browser and go to http://localhost:8080/
```

Note that the site might not work until the database 'test.sql' is fully imported
on the MySQL container, so please wait a few seconds or retry if you receive an
error.
