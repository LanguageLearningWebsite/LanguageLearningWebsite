class Api::V1::RecordingController < ApplicationController
  before_action :authenticate_user!
  respond_to :json

  def new
    Recording.create!(:url => params[:url], :user_id => params[:user_id], :recording_list_id => params[:recording_list_id])
    render :nothing => true
  end
end
