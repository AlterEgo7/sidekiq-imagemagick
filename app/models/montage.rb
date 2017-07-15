class Montage < ApplicationRecord
  include MiniMagick

  before_validation :create_combined_image

  mount_uploader :combined_image, ImageUploader

  validates :left_image, presence: true
  validates :right_image, presence: true, uniqueness: { scope: :left_image }
  validates :combined_image, presence: true

  private

  def create_combined_image
    if left_image.nil? || right_image.nil?
      return
    end

    image1 = Image.open left_image
    image2 = Image.open right_image
    tempfile = Tempfile.new('convert')

    Tool::Convert.new do |convert|
      convert << image1.path
      convert << image2.path
      convert.resize "x#{image1.height}"
      convert.border 20
      convert << '+append'
      convert.border 20
      convert << '+repage'
      convert << tempfile.path
    end

    montage = Image.open(tempfile.path)
    logo = Image.open('app/assets/images/generic_logo.png').resize "x#{montage.height / 15}^"

    result = montage.composite(logo) do |c|
      c.compose :Over
      c.geometry '+100+100'
      c.gravity 'SouthEast'
    end

    self.combined_image = result
    tempfile.delete
  end

end
