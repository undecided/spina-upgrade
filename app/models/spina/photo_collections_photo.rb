module Spina
  class PhotoCollectionsPhoto < ActiveRecord::Base
    belongs_to :photo, optional: true
    belongs_to :photo_collection, optional: true
  end
end
