ActiveAdmin.register Lesson do
  permit_params :id, :title, :note, :video, :header, :position, :course_id, :full_title,
                  captions_attributes: [:id, :label, :language, :file, :_destroy]

  preserve_default_filters!
  remove_filter :components

  config.sort_order = 'position_asc' # assuming Widget.insert_at modifies the `position` attribute
  config.paginate   = false
  reorderable

  index as: :reorderable_table do
    selectable_column
    column :title
    column :course
    column :header
    column :position

    actions
  end

  show do |f|
    attributes_table do
      row :title
      row :course
      row :header
      row :position

      reorderable_table_for f.components.order(:position) do
        column :name
        column :componentable_type
        column :position
      end
    end
  end

  form do |f|
    f.inputs "Lesson" do
      f.input :course, label: "Course"
      f.input :title, label: "Title"
      f.input :note, label: "Note"
      f.input :header, label: "Header"
    end

    actions
  end

  action_item :view, only: :show do
    link_to 'Back', :back
  end

  controller do
    def set_position
      course = Lesson.find(params[:id]).course
      min_position = course.lessons.pluck(:position).min
      params[:position] = (min_position + params[:position].to_i - 1)
    end
  end
end
