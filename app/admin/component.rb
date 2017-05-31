ActiveAdmin.register Component do

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

    actions
  end
end
