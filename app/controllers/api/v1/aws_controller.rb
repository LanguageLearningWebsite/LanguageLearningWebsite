class Api::V1::AwsController < ApplicationController
  before_action :authenticate_user!
  respond_to :json

  def presigned_url
    url = params[:url]
    obj = S3_BUCKET.object(url)
    url = URI.parse(obj.presigned_url(:put))
    render json: {:url => url.to_s}
  end
end
