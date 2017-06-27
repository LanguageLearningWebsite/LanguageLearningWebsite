class Lesson < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: [:slugged, :finders]

  before_create :set_position

  has_many :components, :dependent => :destroy
  belongs_to :course
  acts_as_list scope: :course

  validates :title, presence: true, length: { maximum: 50 }
  validates :course, presence: true

  def full_title
    if header || lesson_header.nil?
      self.course.name + " - " +  self.title
    else
      self.course.name + " - " + lesson_header.title + " - " +  self.title
    end
  end

  def long_title
    if lesson_header
      self.lesson_header.title + " - " +  self.title
    end
  end

  def next
    self.class.where("position > ? AND (header = ? OR header IS NULL) AND course_id = ?", position, false, course_id).first
  end

  def previous
    self.class.where("position < ? AND (header = ? OR header IS NULL) AND course_id = ?", position, false, course_id).last
  end

  def first_component
    self.components.order(:position).first
  end

  def last_component
    self.components.order(:position).last
  end

  def lesson_header
    self.class.where("position < ? AND header = ? AND course_id = ?", position, true, course_id).last
  end

  def set_position
    if position.nil?
      lessons = Lesson.where("course_id = ?", course_id)
      if lessons.empty?
        lessons = Lesson
      end
      max_position = lessons.maximum("position") || 0
      Lesson.where("position > ?", max_position).update_all("position = position + 1")
      self.position = max_position + 1
    end
  end
end
