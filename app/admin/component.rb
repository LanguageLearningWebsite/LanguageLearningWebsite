ActiveAdmin.register Component do
  permit_params :name, :lesson_id, :componentable_type, :componentable_id, :position,
    componentable_attributes: [:id, :url, captions_attributes: [:id, :label, :language, :file, :_destroy]]

  preserve_default_filters!
  remove_filter :componentable_type
  before_action :set_position, only: [:reorder]

  config.sort_order = 'position_asc' # assuming Widget.insert_at modifies the `position` attribute
  config.paginate   = false
  reorderable

  index as: :reorderable_table do
    selectable_column
    column :name
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
      if !f.object.componentable
        f.input :componentable_type, input_html: {class: 'polyselect'},
        collection: Component::COMPONENTABLE_TYPES
      end
    end

    if f.object.componentable_type != 'Recording' && f.object.componentable_type != 'Quiz'
      f.inputs 'Video', for: [:componentable, f.object.componentable || Video.new], id: 'Video_poly', class: css_class do |fc|
        fc.input :url
        fc.has_many :captions, allow_destroy: true, new_record: "Add Captions" do |e|
          e.input :label
          e.input :language
          e.input :file, hint: content_tag(:span, "Upload vtt/srt caption")
        end
      end
    end

    if f.object.componentable_type != 'Video' && f.object.componentable_type != 'Quiz'
      f.inputs 'Recording', for: [:componentable, f.object.componentable || Recording.new], id: 'Recording_poly', class: css_class do |fc|
      end
    end

    actions
  end

  controller do
    def set_position
      lesson = Component.find(params[:id]).lesson
      min_position = lesson.components.pluck(:position).min
      params[:position] = (min_position + params[:position].to_i - 1)
      puts params[:position]
    end
  end
end
