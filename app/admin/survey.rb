ActiveAdmin.register Survey::Survey do
  menu :label => "Surveys"

  filter  :name,
          :as => :select,
          :collection => proc {
              Survey::Survey.select("distinct(name)").collect { |c|
                [c.name, c.name]
              }
          }
  filter :active,
         :as => :select,
         :collection => ["true", "false"]

  filter :created_at

  index do
    column :name
    column :description
    column :active
    column :attempts_number
    column :finished
    column :created_at
    actions
  end

  # form do |f|
  #   f.inputs "Surveys" do
  #     f.input  :name
  #     f.input  :active, :as => :select, :collection => ["true", "false"]
  #     f.input  :attempts_number
  #     f.input  :description
  #   end
  #
  #   f.inputs "Questions" do
  #     f.has_many :questions do |q|
  #       q.input :text
  #       q.input :questions_type_id, :as => :select, :collection => Survey::QuestionsType.questions_types_title
  #       q.has_many :options do |a|
  #         a.input :text
  #         a.input :correct
  #       end
  #     end
  #   end
  #
  #   f.actions
  # end

  form partial: 'form'

  if Rails::VERSION::MAJOR >= 4
    controller do
      def permitted_params
        params.permit!
      end
    end
  end
end
