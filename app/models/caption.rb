class Caption < ActiveRecord::Base
  belongs_to :lesson

  has_attached_file :file, { validate_media_type: false }
  validates_attachment_file_name :file, matches: [/vtt\z/, /srt\z/]
  # validates_attachment_content_type :file, content_type: "text/plain"
  # do_not_validate_attachment_file_type :file

end
