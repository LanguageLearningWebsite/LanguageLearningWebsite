class Api::V1::TranslateController < ApplicationController
  respond_to :json

  def show
    phrase = params[:phrase]
    respond_with Caption.translate(phrase)
  end
end
