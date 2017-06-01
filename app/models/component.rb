class Component < ActiveRecord::Base
  before_create :set_position

  belongs_to :lesson
  acts_as_list scope: :lesson

  belongs_to :componentable, polymorphic: true, :dependent => :destroy
  accepts_nested_attributes_for :componentable, :allow_destroy => true

  COMPONENTABLE_TYPES = %w(Recording Video Quiz)

  def course
  end

  def build_componentable(params)
    raise "Unknown componentable_type: #{componentable_type}" unless COMPONENTABLE_TYPES.include?(componentable_type)
    self.componentable = componentable_type.constantize.new(params)
  end

  def full_title
    self.lesson.full_title + ' - ' + self.name
  end

  def set_position
    if position.nil?
      components = Component.where("lesson_id = ?", lesson_id)
      if components.empty?
        components = Component
      end
      max_position = components.maximum("position") || 0
      Component.where("position > ?", max_position).update_all("position = position + 1")
      self.position = max_position + 1
    end
  end
end
