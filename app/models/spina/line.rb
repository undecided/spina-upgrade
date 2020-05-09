module Spina
  class Line < ApplicationRecord
    extend Mobility
    translates :content, fallbacks: true

    def convert_to_json!
      text = Spina::Parts::Line.new
      text.content = content
      text
    end
  end
end
