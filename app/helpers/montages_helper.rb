require 'csv'
require 'open-uri'

module MontagesHelper
  def import_csv(csv)
    CSV.foreach(csv.path) do |row|
      create_montage(row)
    end
  end


  def export_csv
    CSV.generate do |csv|
      Montage.all.each { |m| csv << [m.left_image.path, m.right_image.path, m.combined_image.path] }
    end
  end

  private

  def create_montage(row)
    MontageWorker.perform_async(row)
  end
end