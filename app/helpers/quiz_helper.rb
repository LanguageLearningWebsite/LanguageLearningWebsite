module QuizHelper
  def link_to_remove_field(name, f)
    f.hidden_field(:_destroy) +
    __link_to_function(raw(name), "removeField(this)", :id =>"remove-attach", class: 'btn btn-default')
  end

  def new_quiz
    new_admin_quiz_quiz_path
  end

  def edit_quiz(resource)
    edit_admin_quiz_quiz_path(resource)
  end

  def quiz_scope(resource)
    if action_name =~ /new|create/
      admin_quiz_quizzes_path(resource)
    elsif action_name =~ /edit|update/
      admin_quiz_quiz_path(resource)
    end
  end

  def attempt_scope(resource)
    if action_name =~ /new|create/
      attempts_path(resource)
    elsif action_name =~ /edit|update/
      attempt_path(resource)
    end
  end

  def link_to_add_field(name, f, association)
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object,:child_index => "new_#{association}") do |builder|
      render(association.to_s.singularize + "_fields", :f => builder)
    end
    __link_to_function(name, "addField(this, \"#{association}\", \"#{escape_javascript(fields)}\")",
    :id=>"add-attach",
    :class=>"btn btn-default")
  end

  def get_answer_fields attempt
    attempt.quiz.questions.map { |q| Quiz::Answer.new(question_id: q.id) }
  end

  def the_chosen_one? answer, option
    if answer.option_id == option.id then 'chosen' else nil end
  end

  def number_of_people_who_also_answered option_id
    count = number_of_people_who_also_answered_count(option_id)
    "<span class='number'> #{count} </span> #{'answer'.pluralize}".html_safe
  end

  def get_color_of_option answer, option
    # if is_quiz?(answer.question.quiz.quiz_type)
      if option.correct
        'bg-success'
      elsif the_chosen_one?(answer, option)
        'bg-danger'
      end
    # elsif is_score?(answer.question.quiz.quiz_type)
    #   get_weight_html_class option
    # end
  end

  def get_weight option
    # return unless is_score?(option.question.quiz.quiz_type)
    # option.weight > 0 ? "(+#{option.weight})" : "(#{option.weight})"
  end

  def get_weight_html_class option
    return 'bg-warning' if option.weight == 0
    option.weight > 0 ? 'bg-success' : 'bg-danger'
  end

  def number_of_questions quiz
    quiz.questions.count
  end

  def number_of_attempts quiz
    quiz.attempts.count
  end

  private

  def __link_to_function(name, on_click_event, opts={})
    link_to(name, 'javascript:;', opts.merge(onclick: on_click_event))
  end

  def has_weights? quiz
    quiz.questions.map(&:options).flatten.any? { |o| o.weight != 0 }
  end
end
