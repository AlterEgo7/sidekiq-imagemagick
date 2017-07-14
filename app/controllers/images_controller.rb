class ImagesController < ApplicationController
  include MontagesHelper

  def upload
  end

  def perform_upload
    if params[:images][:csv].content_type != 'text/csv'
      flash[:error] = 'Uploaded file not csv'
    end

    import_csv(params[:images][:csv].tempfile)
    redirect_to root_path
  end
end
