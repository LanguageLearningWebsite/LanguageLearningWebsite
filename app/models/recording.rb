class Recording < ActiveRecord::Base
  belongs_to :user
  belongs_to :recording_list
  validates :user, :recording_list, :url, presence: true
  validate :validate_number_of_recordings, :on => :create

  before_destroy :delete_s3

  def presigned_url
    obj = S3_BUCKET.object(self.url)
    URI.parse(obj.presigned_url(:get))
  end

  def delete_s3
    s3 = Aws::S3::Client.new
    response = s3.delete_object({
        bucket: ENV['S3_BUCKET'],
        key: url
    })
  end

  private
  def validate_number_of_recordings
    errors.add(:recordings, "Maximum number of recordings exceeded.") if (!recording_list.check_limit(user))
  end
end
