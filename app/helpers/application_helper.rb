module ApplicationHelper
	def avatar_url(user)
    gravatar_id = Digest::MD5::hexdigest(user.email).downcase
    "https://www.gravatar.com/avatar/#{gravatar_id}.jpg?d=identicon&s=40"
  end

	def number_of_people_who_also_answered_count option_id
		Quiz::Answer.where(option_id: option_id).count
	end
end
