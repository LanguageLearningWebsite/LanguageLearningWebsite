class PagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_s3_base_url

  def about
  end

  private
  def set_s3_base_url
    @s3_base_url = "uploads/#{SecureRandom.uuid}/"
  end
end
