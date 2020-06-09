module Spina
  class AttachmentCollection < ApplicationRecord
    has_and_belongs_to_many :attachments, join_table: 'spina_attachment_collections_attachments'

    # There's no attachment collection equivalent in Spina 2
    # Instead, create a line with comma separated ID's of attachments
    def convert_to_json!
      json_part = Spina::Parts::Line.new
      json_part.content = attachments.ids.join(", ")
      json_part
    end

  end
end
