require 'google/apis/translate_v2'

class Caption < ActiveRecord::Base
  belongs_to :lesson

  has_attached_file :file, { validate_media_type: false }
  validates_attachment_file_name :file, matches: [/vtt\z/, /srt\z/]
  # validates_attachment_content_type :file, content_type: "text/plain"
  # do_not_validate_attachment_file_type :file
  translate = Google::Apis::TranslateV2::TranslateService.new
  translate.key = 'AIzaSyArfX4fksilhZV8x_P8RrErB0ExR26u11A'

  def self.translate(word, source_language, target_language)
    result = translate.list_translations(word, target_language, source: source_language)
    puts result.translations.first.translated_text
  end

end
