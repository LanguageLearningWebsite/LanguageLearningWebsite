class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :enrollments
  has_many :courses, through: :enrollments
  has_many :recordings, :dependent => :destroy
  has_many :recording_lists, through: :recordings
  has_many :quiz_tentatives, as: :participant, :class_name => ::Attempt

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :first_name, presence: true, length: {maximum: 15}
  validates :last_name, presence: true, length: {maximum: 15}
  validates :username, presence: true, length: {maximum: 25}

  def for_quiz quiz
    self.quiz_tentatives.where(:quiz_id => quiz.id)
  end
end
