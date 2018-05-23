module Spina
  class UpgradeGenerator < Rails::Generators::Base

    def copy_migrations
      return if Rails.env.production?
      rake 'spina_upgrade:install:migrations'
    end

    def run_migrations
      rake 'db:migrate'
    end

    def upgrade
      rake 'spina:photo_to_image'
    end

    def done
      puts "Upgrade done"
    end

  end
end