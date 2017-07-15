require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the ImagesHelper. For example:
#
# describe ImagesHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe MontagesHelper, type: :helper do
  describe 'export csv' do
    before do
      @montage = create :montage
    end

    it 'should return csv data' do
      expect(CSV.parse(export_csv)[0]).to eq [@montage.left_image.path, @montage.right_image.path, @montage.combined_image.path]
    end
  end

  describe 'import csv' do
    before do
      @montage_attributes = attributes_for :montage
      csv = @montage_attributes.values.map(&:path).to_csv
      @tempfile = Tempfile.new('csv')
      File.open(@tempfile, 'w') { |f| f.write csv }
      import_csv(@tempfile)
    end

    after do
      File.delete @tempfile
    end

    it 'should create montage' do
      montage = Montage.first
      expect(FileUtils.compare_file(File.open(montage.left_image.path), File.open(@montage_attributes[:left_image])))
      expect(FileUtils.compare_file(File.open(montage.right_image.path), File.open(@montage_attributes[:right_image])))
    end
  end
end
