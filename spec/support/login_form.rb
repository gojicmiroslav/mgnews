class LoginForm
	include Capybara::DSL
	include Warden::Test::Helpers
	Warden.test_mode!

	def visit_page(url)
		visit url
		self
	end

	def login_as(user)
		fill_in("Email", with: user.email)
		fill_in("Password", with: user.password)
		click_on("Log in")
	end

end