module Spina
  class Option < ApplicationRecord

    def convert_to_json!
      text = Spina::Parts::Option.new
      text.value = value
      text
    end

  end
end
