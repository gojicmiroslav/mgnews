module ControllerMacros
  def login_editor
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:editor]
      editor = FactoryGirl.create(:user_editor)
      sign_in :user, editor
    end
  end

  def login_regular
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:regular]
      user = FactoryGirl.create(:user_regular)
      user.confirm! # or set a confirmed_at inside the factory. Only necessary if you are using the "confirmable" module
      sign_in :user, user
    end
  end
end