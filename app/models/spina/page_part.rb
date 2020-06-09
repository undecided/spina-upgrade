module Spina
  class PagePart < ApplicationRecord
    belongs_to :page
    belongs_to :page_partable, polymorphic: true

    def convert_to_json!
      json_part = page_partable.convert_to_json!
      json_part.name = name
      json_part
    end
  end
end
