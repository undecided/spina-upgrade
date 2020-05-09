module Spina
  class AttachmentCollection < ApplicationRecord

    has_one :page_part, as: :page_partable
    has_many :structure_parts, as: :structure_partable
    has_and_belongs_to_many :attachments, join_table: 'spina_attachment_collections_attachments'

    attr_reader :attachment_tokens
    accepts_nested_attributes_for :attachments, allow_destroy: true

    def content
      self
    end

    def attachment_tokens=(ids)
      self.attachment_ids = ids.split(",")
    end

    # There's no attachment collection equivalent in Spina 2
    # Instead, create a line with comma separated ID's of attachments
    def convert_to_json!
      json_part = Spina::Parts::Line.new
      json_part.content = attachments.ids.join(", ")
      json_part
    end

  end
end
