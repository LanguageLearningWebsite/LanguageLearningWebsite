class Recording < ActiveRecord::Base
  belongs_to :user
  belongs_to :recording_list
end
