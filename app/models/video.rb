class Video < ActiveRecord::Base
  has_one :component, as: :componentable, :dependent => :destroy

  has_many :captions
  accepts_nested_attributes_for :captions, :allow_destroy => true
end
