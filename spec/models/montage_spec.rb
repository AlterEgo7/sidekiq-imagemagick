require 'rails_helper'

describe 'Montage' do

  # describe 'test' do
  #   before do
  #     @test = build :montage
  #     @test.save!
  #   end
  #
  #   it 'should work' do
  #     expect(@test).to validate_presence_of :left_image
  #   end
  # end

  subject { build_stubbed :montage }

  it { is_expected.to validate_presence_of :left_image }
  it { is_expected.to validate_presence_of :right_image }
end
