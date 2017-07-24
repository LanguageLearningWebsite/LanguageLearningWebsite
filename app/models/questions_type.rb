class QuestionsType
  @@questions_types = {:multiple_choice => 1, :fill_in_blank => 2}

  def self.questions_types
    @@questions_types
  end

  def self.questions_types_title
    titled = {}
    QuestionsType.questions_types.each{|k, v| titled[k.to_s.titleize] = v}
    titled
  end

  def self.questions_type_ids
    @@questions_types.values
  end

  def self.questions_type_keys
    @@questions_types.keys
  end

  @@questions_types.each do |key, val|
    define_singleton_method "#{key}" do
      val
    end
  end
end
