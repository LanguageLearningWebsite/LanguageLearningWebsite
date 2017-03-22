ActiveAdmin.register Course do
  permit_params :name, :content, :image

  show do |t|
    attributes_table do
      row :name
      row :content
      row :image do
        course.image? ? image_tag(course.image.url, height: '100') : content_tag(:span, "No photo yet")
      end
    end
  end

  form :html => { :enctype => "multipart/form-data"} do |f|
    f.inputs do
      f.input :name
      f.input :content
      f.input :image, hint: f.course.image? ? image_tag(course.image.url, height: '100') : content_tag(:span, "Upload JPG/PNG/GIF image")
    end
    f.actions
  end

  action_item :view, only: :show do
    link_to 'Back', :back
  end
end
