module Spina
  class Structure < ApplicationRecord
    has_one :page_part, as: :page_partable
    has_many :structure_items

    after_save -> { structure_items.each(&:save) }

    accepts_nested_attributes_for :structure_items, allow_destroy: true

    def content
      self
    end

    def convert_to_json!
      repeater = Spina::Parts::Repeater.new
      repeater.content = structure_items.order(:position).map do |structure_item|
        json_structure_item = structure_item.convert_to_json!
        json_structure_item.name = page_part.name
        json_structure_item
      end
      repeater
    end
  end
end
