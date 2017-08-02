ActiveAdmin.register Recording do

  index do
    selectable_column
    column :id
    column :user, sortable: :user
    column :url do |recording|
      user = recording.user
      component = recording.recording_list.component
      link_to "#{user.last_name} - #{component.name}", recording.presigned_url.to_s, target: :_blank
    end
    column :lesson, sortable: :lesson do |recording|
      lesson = recording.recording_list.component.lesson
      link_to lesson.long_title, admin_lesson_path(lesson)
    end
    column :course, sortable: :course do |recording|
      course = recording.recording_list.component.lesson.course
      link_to course.name, admin_course_path(course)
    end
    column :created_at
    column :submitted

    actions
  end
end
