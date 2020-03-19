def user_log_in(email = "example@example.com", password = "password1")
  visit "/users/sign_in"
  fill_in "Email", with: email
  fill_in "Password", with: password
  click_button "Log in"
end
