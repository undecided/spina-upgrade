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
      rake 'spina:convert_page_parts_to_json'
      rake 'spina:convert_layout_parts_to_json'
    end

    def done
      puts "Upgrade done"
    end

  end
end