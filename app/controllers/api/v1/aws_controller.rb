class Api::V1::AwsController < ApplicationController
  before_action :authenticate_user!
  respond_to :json

  def presigned_url
    base_url = params[:base_url]
    file_name = params[:file_name]
    obj = S3_BUCKET.object(base_url + file_name)
    url = URI.parse(obj.presigned_url(:put))
    respond_with :url => url.to_s
  end
end
