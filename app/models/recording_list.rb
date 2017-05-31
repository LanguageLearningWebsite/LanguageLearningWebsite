class RecordingList < ActiveRecord::Base
  has_one :component, as: :componentable, :dependent => :destroy
  has_many :recordings
  has_many :users, through: :recordings
  
  accepts_nested_attributes_for :recordings, :allow_destroy => true
end
