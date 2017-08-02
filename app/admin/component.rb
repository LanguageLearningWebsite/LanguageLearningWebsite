ActiveAdmin.register Component do
  # permit_params :name, :lesson_id, :componentable_type, :componentable_id, :position,
  #   componentable_attributes: [:id, :url, :limit, :attempts_number, :description, :active,
  #      captions_attributes: [:id, :file, :_destroy],
  #      questions_attributes: [:text, options_attributes: [:text, :correct]]]

  preserve_default_filters!
  remove_filter :componentable_type
  before_action :set_position, only: [:reorder]

  config.sort_order = 'position_asc' # assuming Widget.insert_at modifies the `position` attribute
  config.paginate   = false
  reorderable

  # index as: :reorderable_table do
  index do
    selectable_column
    column :name
    column :course_name
    column :lesson
    column "Type", :componentable_type
    column :position

    actions
  end

  form do |f|
    css_class = f.object.componentable ? "inputs" : "inputs polyform"

    f.inputs "Component" do
      f.input :name
      default_course = f.object.lesson.course.name if f.object.lesson
      default_lesson = f.object.lesson.id if f.object.lesson
      input :course, as: :select, collection: options_for_select(Course.pluck(:name), default_course)
      f.input :lesson, as: :select, collection: option_groups_from_collection_for_select(Course.all, :lessons, :name, :id, :title, default_lesson)
      if !f.object.componentable_type
        f.input :componentable_type, label: "Type", input_html: {class: 'polyselect'}, collection: Component::COMPONENTABLE_TYPES
      else
        f.input :componentable_type, label: "Type", input_html: {class: 'polyselect'}, collection: [f.object.componentable_type]
      end
    end

    if f.object.componentable_type != 'RecordingList' && f.object.componentable_type != 'Quiz'
      f.inputs 'Video', for: [:componentable, f.object.componentable || Video.new], id: 'Video_poly', class: css_class do |fc|
        fc.input :url
        fc.has_many :captions, allow_destroy: true, new_record: "Add Captions" do |e|
          file_name = e.object.file_file_name
          e.input :file, hint: file_name ? link_to(file_name, e.object.file.url) : content_tag(:span, "Upload vtt/srt caption")
        end
      end
    end

    if f.object.componentable_type != 'Video' && f.object.componentable_type != 'Quiz'
      f.inputs 'RecordingList', for: [:componentable, f.object.componentable || RecordingList.new], id: 'RecordingList_poly', class: css_class do |fc|
        fc.input :limit
      end
    end

    if f.object.componentable_type != 'Video' && f.object.componentable_type != 'RecordingList'
      f.inputs 'Quiz', for: [:componentable, f.object.componentable || Quiz.new], id: 'Quiz_poly', class: css_class do |fc|
        fc.input :attempts_number, label: "Maximum attempts", hint: "0 is infinite"
        fc.input :description, :input_html => { :rows => 8 }
        fc.input :active
        fc.has_many :questions, allow_destroy: true, new_record: "Add question" do |q|
          q.input :text, label: false, placeholder: 'question', :input_html => { :rows => 5 }
          q.has_many :options, allow_destroy: true, heading: false, new_record: "Add option" do |o|
            o.input :text, label: false,  placeholder: 'answer', :wrapper_html => { :class => 'multiCol' }
            o.input :correct, label: false, :wrapper_html => { :class => 'multiCol' }
          end
        end
      end
    end

    actions
  end

  controller do
    def permitted_params
      params.permit!
    end

    def set_position
      lesson = Component.find(params[:id]).lesson
      min_position = lesson.components.pluck(:position).min
      params[:position] = (min_position + params[:position].to_i - 1)
      puts params[:position]
    end
  end
end
