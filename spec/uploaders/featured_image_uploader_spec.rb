require 'rails_helper'

RSpec.describe FeaturedImageUploader do

	it 'allows only images' do
		uploader = FeaturedImageUploader.new(Article.new, :featured_image)

		expect {
			File.open("#{Rails.root}/spec/fixtures/empty_pdf.pdf") do |f|
				uploader.store!(f)
			end		
		}.to raise_exception(CarrierWave::IntegrityError)
	end

end	