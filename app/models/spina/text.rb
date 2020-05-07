module Spina
  class Text < ApplicationRecord
    extend Mobility

    translates :content, fallbacks: true
    
    has_many :page_parts, as: :page_partable
    has_many :layout_parts, as: :layout_partable
    has_many :structure_parts, as: :structure_partable

    def convert_to_json!
      text = Spina::Parts::Text.new
      text.content = content
      text
    end
  end
end
