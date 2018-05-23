require 'spina'
require 'carrierwave'

module Spina
  module Upgrade
    class Engine < ::Rails::Engine
      isolate_namespace Spina::Upgrade

      config.autoload_paths += %W( #{config.root}/lib )
    end
  end
end
