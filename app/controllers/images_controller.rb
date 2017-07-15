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
    flash[:info] = 'Upload submitted'
    redirect_to root_path
  end

  def download
    if Montage.count == 0
      flash[:info] = 'No images uploaded.'
      redirect_to root_path
    else
      csv = export_csv
      send_data csv, filename: 'montages.csv'
    end
  end
end
