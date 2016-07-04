require 'rails_helper'

RSpec.describe Category, type: :model do
  
  describe "validations" do
  	it { should validate_presence_of :name}
  	it { should validate_presence_of :menu_order}
  end
end
