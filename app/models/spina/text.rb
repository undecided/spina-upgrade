module Spina
  class Text < ApplicationRecord
    extend Mobility
    translates :content, fallbacks: true

    def convert_to_json!
      text = Spina::Parts::Text.new
      text.content = content
      text
    end
  end
end
