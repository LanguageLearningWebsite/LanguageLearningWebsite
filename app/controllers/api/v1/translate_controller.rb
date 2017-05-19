class Api::V1::TranslateController < ApplicationController
  before_action :authenticate_user!
  respond_to :json

  def show
    phrase = params[:phrase]
    respond_with Caption.translate(phrase)
  end
end
