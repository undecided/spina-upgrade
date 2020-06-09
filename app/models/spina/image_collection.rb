module Spina
  class ImageCollection < ApplicationRecord
    has_one :page_part, as: :page_partable
    has_many :image_collections_images
    has_many :images, through: :image_collections_images
    
    def convert_to_json!
      json_part = Spina::Parts::ImageCollection.new
      json_part.images = images.order(:position).map do |image|
        image_json_part = image.convert_to_json!
        image_json_part.name = page_part.name
        image_json_part
      end
      json_part
    end

  end
end
