module Spina
  module Upgrade
    module AttachmentDecorator

      def convert_to_json!
        attachment = Spina::Parts::Attachment.new
        attachment.attachment_id = id
        attachment.signed_blob_id = file&.blob&.signed_id
        attachment.filename = name
        attachment
      end
      
    end
  end
end