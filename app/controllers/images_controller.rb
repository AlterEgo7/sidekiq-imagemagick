class ImagesController < ApplicationController
  include MontagesHelper

  def upload
  end

  def perform_upload
    if params[:images][:csv].content_type != 'text/csv'
      flash[:error] = 'Uploaded file not csv'
    end

    begin
      import_csv(params[:images][:csv].tempfile)
    rescue Errno::ENOENT => ex
      invalid_link = ex.message.split('-').last.strip
      flash[:error] = "Invalid link in CSV: #{invalid_link}"
    end
    redirect_to root_path
  end
end
