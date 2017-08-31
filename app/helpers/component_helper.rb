module ComponentHelper
  def get_component_class(component)
    component.id == @component.id ? "nav-link active" : "nav-link"
  end

  def get_component_url(component)
    if component.componentable_type == 'Quiz'
      new_course_lesson_component_attempt_path(@course, @lesson, component)
    else
      course_lesson_component_path(@course, @lesson, component)
    end
  end

  def get_previous_lesson_url
    course = @prev_lesson.course
    lesson = @prev_lesson
    component = @prev_lesson.last_component
    return unless component
    if component.componentable_type == 'Quiz'
      new_course_lesson_component_attempt_path(course, lesson, component)
    else
      course_lesson_component_path(course, lesson, component)
    end
  end

  def get_next_lesson_url
    course = @next_lesson.course
    lesson = @next_lesson
    component = @next_lesson.first_component
    return unless component
    if component.componentable_type == 'Quiz'
      new_course_lesson_component_attempt_path(course, lesson, component)
    else
      course_lesson_component_path(course, lesson, component)
    end
  end
end
