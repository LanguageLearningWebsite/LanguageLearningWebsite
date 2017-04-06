require 'aws-sdk'

class Caption < ActiveRecord::Base
  belongs_to :lesson

  has_attached_file :file, { validate_media_type: false }
  validates_attachment_file_name :file, matches: [/vtt\z/, /srt\z/]

  def self.translate(words)
    lambda = Aws::Lambda::Client.new(region: 'us-east-1', access_key_id: ENV['AWS_LAMBDA_ACCESS_KEY'], secret_access_key: ENV['AWS_LAMBDA_SECRET_KEY'])
    resp = lambda.invoke(function_name: 'translate', invocation_type: 'RequestResponse', payload: "{\"words\": \"#{words}\" }")
    return JSON.parse(resp.payload.string)
  end
end
