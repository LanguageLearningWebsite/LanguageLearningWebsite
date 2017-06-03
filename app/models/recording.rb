class Recording < ActiveRecord::Base
  belongs_to :user
  belongs_to :recording_list

  def presigned_url
    obj = S3_BUCKET.object(self.url)
    URI.parse(obj.presigned_url(:get))
  end
end
