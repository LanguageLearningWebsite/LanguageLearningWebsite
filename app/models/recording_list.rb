class RecordingList < ActiveRecord::Base
  has_one :component, as: :componentable, :dependent => :destroy
  has_many :recordings, :dependent => :destroy
  has_many :users, through: :recordings
  
  accepts_nested_attributes_for :recordings, :allow_destroy => true

  def check_limit(user)
    uploaded_recordings = recordings_for(user)
    uploaded_recordings.count < limit
  end

  def check_submission(user)
    uploaded_recordings = recordings_for(user)
    uploaded_recordings.where(:submitted => true).exists?
  end

  def recordings_for(user)
    recordings.where(:user => user)
  end
end
