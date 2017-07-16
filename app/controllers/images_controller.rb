class ImagesController < ApplicationController
  include MontagesHelper

  def upload
  end

  def perform_upload
    begin
      if image_params.content_type != 'text/csv'
        flash[:error] = 'Uploaded file not csv'
      else
        import_csv(image_params.tempfile)
        flash[:info] = 'Upload submitted'
      end
    rescue ActionController::ParameterMissing => er
      flash[:error] = 'No file uploaded'
    end

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

  private

  def image_params
    params.require(:images).require(:csv)
  end
end
