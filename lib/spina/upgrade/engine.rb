require 'spina'
require 'carrierwave'

# Decorators for convert_to_json!
require 'spina/upgrade/decorators/attachment_decorator'
require 'spina/upgrade/decorators/image_decorator'

module Spina
  module Upgrade
    class Engine < ::Rails::Engine
      isolate_namespace Spina::Upgrade

      config.autoload_paths += %W( #{config.root}/lib )

      config.to_prepare do
        Spina::Image.prepend(Spina::Upgrade::ImageDecorator)
        Spina::Attachment.prepend(Spina::Upgrade::AttachmentDecorator)
      end

    end
  end
end
