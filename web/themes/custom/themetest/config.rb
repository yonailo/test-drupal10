#
# If you'd like to learn more about Sass and Compass, see the sass/README.txt
# file for more information.
#
Encoding.default_external = 'utf-8'
# Environments: when ready to deploy the CSS to the live server, use "compass compile --force -e production"
if environment == :production
  output_style = :compressed
else
  output_style = :expanded
  enable_sourcemaps = true
  sass_options = {:sourcemap => true}
end

# Location of the theme's resources.
css_dir         = "css"
sass_dir        = "sass"
extensions_dir  = "sass-extensions"
images_dir      = "images"
# generated_images_dir      = "images"
http_images_dir = "images"
javascripts_dir = "js"
fonts_dir		    = "fonts"

# To enable relative paths to assets via compass helper functions. Since Drupal
# themes can be installed in multiple locations, we don't need to worry about
# the absolute path to the theme from the server root.
relative_assets = true

# Cache buster: remove hash in the sprite file name (would be even better if we called <spritefile.png>#hash in css, I don't know how to do this)
# Source: http://stackoverflow.com/a/16478392
module Compass::SassExtensions::Functions::Sprites
  def sprite_url(map)
    verify_map(map, "sprite-url")
    map.generate
    generated_image_url(Sass::Script::String.new(map.name_and_hash))
  end
end

module Compass::SassExtensions::Sprites::SpriteMethods
  def name_and_hash
    "sprite-#{path}.png"
  end

  def cleanup_old_sprites
    Dir[File.join(::Compass.configuration.generated_images_path, "sprite-#{path}.png")].each do |file|
      log :remove, file
      FileUtils.rm file
      ::Compass.configuration.run_sprite_removed(file)
    end
  end
end

module Compass
  class << SpriteImporter
    def find_all_sprite_map_files(path)
      glob = "sprite-*{#{self::VALID_EXTENSIONS.join(",")}}"
      Dir.glob(File.join(path, "**", glob))
    end
  end
end