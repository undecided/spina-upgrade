module Spina
  class ImageCollection < ApplicationRecord
    include ImageCollectable

    has_one :page_part, as: :page_partable
    has_many :image_collections_images, autosave: true
    has_many :images, through: :image_collections_images
    has_many :structure_parts, as: :structure_partable

    accepts_nested_attributes_for :images, allow_destroy: true

    def content
      self
    end

    alias_method :old_update, :update
    def update(attributes)
      self.images.clear if attributes.reject{|key,value| key == "id" }.blank?
      old_update(attributes)
    end

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
