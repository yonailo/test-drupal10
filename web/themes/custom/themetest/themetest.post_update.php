<?php

/**
 * @file
 * Post update functions for themetest.
 */

/**
 * Sets the default `base_primary_color` value of themetest's theme settings.
 */
function themetest_post_update_add_themetest_primary_color() {
  \Drupal::configFactory()->getEditable('themetest.settings')
    ->set('base_primary_color', '#1b9ae4')
    ->save();
}
