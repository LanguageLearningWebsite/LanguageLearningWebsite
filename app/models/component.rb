class Component < ActiveRecord::Base
  belongs_to :lesson
  belongs_to :componentable, polymorphic: true, :dependent => :destroy
  accepts_nested_attributes_for :componentable, :allow_destroy => true

  COMPONENTABLE_TYPES = %w(Recording Video Quiz)

  def course
  end

  def build_componetable(params)
    raise "Unknown componentable_type: #{componentable_type}" unless COMPONENTABLE_TYPES.include?(componentable_type)
    self.componetable = componentable_type.constantize.new(params)
  end
end
