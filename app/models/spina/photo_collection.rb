module Spina
  class PhotoCollection < ActiveRecord::Base
    has_one :page_part, as: :page_partable
    has_many :photo_collections_photos
    has_many :photos, through: :photo_collections_photos
    has_many :structure_parts, as: :structure_partable

    accepts_nested_attributes_for :photos, allow_destroy: true
  end
end
