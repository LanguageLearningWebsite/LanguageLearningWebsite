class Lesson < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: [:slugged, :finders]

  before_create :set_tag

  belongs_to :course

  validates :title, presence: true, length: { maximum: 50 }
  validates :video, presence: true
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
    self.class.where("tag > ? AND (header = ? OR header IS NULL) AND course_id = ?", tag, false, course_id).first
  end

  def previous
    self.class.where("tag < ? AND (header = ? OR header IS NULL) AND course_id = ?", tag, false, course_id).last
  end

  def lesson_header
    self.class.where("tag < ? AND header = ? AND course_id = ?", tag, true, course_id).last
  end

  def set_tag
    if tag.nil?
      lessons = Lesson.where("course_id = ?", course_id)
      if lessons.empty?
        lessons = Lesson
      end
      max_tag = lessons.maximum("tag")
      Lesson.where("tag > ?", max_tag).update_all("tag = tag + 1")
      self.tag = max_tag + 1
    end
  end
end
