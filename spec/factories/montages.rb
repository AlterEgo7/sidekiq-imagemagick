FactoryGirl.define do
  factory :montage do
    left_image { File.join(Rails.root, 'spec', 'support', 'images', 'image1.jpg') }
    right_image { File.join(Rails.root, 'spec', 'support', 'images', 'image2.jpg') }
  end
end
