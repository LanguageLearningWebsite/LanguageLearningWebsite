require 'aws-sdk'

class Caption < ActiveRecord::Base
  belongs_to :lesson

  has_attached_file :file, { validate_media_type: false }
  validates_attachment_file_name :file, matches: [/vtt\z/, /srt\z/]
  # validates_attachment_content_type :file, content_type: "text/plain"
  # do_not_validate_attachment_file_type :file

  def self.translate(words)
    # translate = Google::Apis::TranslateV2::TranslateService.new
    # translate.key = 'AIzaSyArfX4fksilhZV8x_P8RrErB0ExR26u11A'
    # result = translate.list_translations(word, target_language, source: source_language)
    # return result.translations
    lambda = Aws::Lambda::Client.new(region: 'us-east-1', access_key_id: ENV['AWS_LAMBDA_ACCESS_KEY'], secret_access_key: ENV['AWS_LAMBDA_SECRET_KEY'])
    resp = lambda.invoke(function_name: 'translate', invocation_type: 'RequestResponse', payload: "{\"words\": \"#{words}\" }")
    return JSON.parse(resp.payload.string)
  end

  def self.test
    translate("大家")
  end
end
