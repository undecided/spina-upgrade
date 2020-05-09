module Spina
  class StructurePart < ApplicationRecord
    belongs_to :structure_partable, polymorphic: true

    def convert_to_json!
      new_part = structure_partable.convert_to_json!
      new_part.name = name
      new_part
    end
  end
end
