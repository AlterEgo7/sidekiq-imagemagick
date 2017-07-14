FactoryGirl.define do
  factory :montage do
    left_image { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'support', 'images', 'image1.jpg'), 'image/jpg') }
    right_image { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'support', 'images', 'image2.jpg'), 'image/jpg') }
  end
end
