module Spina
  module Upgrade
    module ImageDecorator

      def convert_to_json!
        image = Spina::Parts::Image.new
        image.image_id = id
        image.signed_blob_id = file&.blob&.signed_id
        image.filename = name
        image
      end
      
    end
  end
end