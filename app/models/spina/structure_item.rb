module Spina
  class StructureItem < ApplicationRecord
    has_many :structure_parts

    def convert_to_json!
      repeater_content = Spina::Parts::RepeaterContent.new
      repeater_content.parts = structure_parts.map do |structure_part|
        next unless structure_part.structure_partable.respond_to?(:convert_to_json!)
        new_part = structure_part.convert_to_json!
        new_part.name = structure_part.name
        new_part
      end.compact
      repeater_content
    end

  end
end
