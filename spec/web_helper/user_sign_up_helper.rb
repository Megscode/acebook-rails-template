def user_sign_up(email = "example@example.com", password = "password1")
  visit "/users/sign_up"
  fill_in "Email", with: email
  fill_in "Password", with: password
  click_button "Sign up"
end
