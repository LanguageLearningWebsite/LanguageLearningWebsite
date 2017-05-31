ActiveAdmin.register Component do
  permit_params :name, :componentable_type, :componentable_id,
    componentable_attributes: [:id, :url, captions_attributes: [:id, :label, :language, :file, :_destroy]]

  form do |f|
    css_class = f.object.componentable ? "inputs" : "inputs polyform"

    f.inputs "Component" do
      input :course, as: :select, collection: Course.all
      f.input :lesson, as: :select, collection: option_groups_from_collection_for_select(Course.all, :lessons, :name, :id, :title)
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

    actions
  end

  controller do
    def create
      @component = Component.new permitted_params[:component]
      if @component.save
        redirect_to collection_path
      end
    end
  end
end
