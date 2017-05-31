ActiveAdmin.register Lesson do
  permit_params :id, :title, :note, :video, :header, :tag, :course_id, :full_title,
                  captions_attributes: [:id, :label, :language, :file, :_destroy]

  sortable tree: false,
            sorting_attribute: :tag

  index :as => :sortable do
		label :full_title

		actions
	end

  index do
    selectable_column
    column :header
    column :title
    column :tag
    column :course

    actions
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
end
