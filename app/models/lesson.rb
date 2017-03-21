class Lesson < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: [:slugged, :finders]

  belongs_to :course

  validates :title, presence: true, length: { maximum: 50 }
  validates :video, presence: true
  validates :tag, presence: true
  validates :course, presence: true

  def next
    self.class.where("id > ?", id).first
  end

  def previous
    self.class.where("id < ?", id).last
  end
end
