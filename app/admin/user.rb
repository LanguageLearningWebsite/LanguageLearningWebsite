ActiveAdmin.register User do
  permit_params :email, :first_name, :last_name, :username

  index do
    selectable_column
    column :email
    column :username
    column :first_name
    column :last_name

    actions
  end

  form do |f|
    f.inputs do
      f.input :email, label: "Email"
      f.input :username, label: "Username"
      f.input :first_name, label: "First name"
      f.input :last_name, label: "Last name"
    end

    actions
  end

  action_item :view, only: :show do
    link_to 'Back', :back
  end
end
