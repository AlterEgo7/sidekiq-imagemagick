class ImagesController < ApplicationController
  def upload
  end

  def perform_upload
    if params[:images][:csv].content_type != 'text/csv'
      flash[:error] = 'Uploaded file not csv'
    end
    flash[:success] = 'Correct file'
    redirect_to root_path
  end
end
