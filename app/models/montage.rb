class Montage < ApplicationRecord
  include MiniMagick

  before_validation :calculate_hash_code
  before_validation :create_combined_image

  mount_uploader :left_image, ImageUploader
  mount_uploader :right_image, ImageUploader
  mount_uploader :combined_image, ImageUploader

  validates :left_image, presence: true
  validates :right_image, presence: true
  validates :combined_image, presence: true
  validates :hash_code, presence:true, uniqueness: true

  private

  def calculate_hash_code
    left_hash = Digest::SHA256.file left_image.file.file
    right_hash = Digest::SHA256.file right_image.file.file
    self.hash_code = Digest::SHA256.hexdigest left_hash.to_s + right_hash.to_s
  end

  def create_combined_image
    image1 = Image.open left_image.path
    image2 = Image.open right_image.path
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
