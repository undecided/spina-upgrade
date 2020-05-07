module Spina
  class StructureItem < ApplicationRecord
    include LegacyPartable

    before_validation :ensure_position
    belongs_to :structure, optional: true
    has_many :structure_parts, dependent: :destroy

    scope :sorted_by_structure, -> { order(:position) }

    after_save -> { structure_parts.each(&:save) }

    validates_presence_of :position
    accepts_nested_attributes_for :structure_parts, allow_destroy: true

    alias_attribute :parts, :structure_parts

    def ensure_position
      self.position ||= Time.now.to_i
    end

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
