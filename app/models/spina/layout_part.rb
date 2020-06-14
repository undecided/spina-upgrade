module Spina
  class LayoutPart < ApplicationRecord
    belongs_to :account
    belongs_to :layout_partable, polymorphic: true

    def convert_to_json!
      json_part = layout_partable.convert_to_json!
      json_part.name = name
      json_part
    end
  end
end
