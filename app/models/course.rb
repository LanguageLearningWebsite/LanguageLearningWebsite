class Course < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: [:slugged, :finders]

  has_many :lessons, -> { order(:position) }, dependent: :destroy
  has_many :enrollments, dependent: :destroy
  has_many :users, through: :enrollments

  validates :name, presence: true, length: { maximum: 50 }
  validates :content, presence: true, length: { maximum: 500 }

  has_attached_file :image, styles: { medium: "680x300>", small: "340x150>", thumb: "170x75>" }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

  def shortname
    name.length > 40 ? name[0..40] + "..." : name
  end
end
