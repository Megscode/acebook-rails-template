require "rails_helper"

RSpec.feature "Timeline", type: :feature do
  scenario "User can see edit button" do
    user_sign_up

    visit "/posts"
    click_link "New post"
    fill_in "Message", with: "Hello, world!"
    click_button "Submit"
    expect(page.all("#posts").first.text).to include("Edit this post")
  end

  scenario "User can edit their post" do
    user_sign_up

    visit "/posts"
    click_link "New post"
    fill_in "Message", with: "Hello, world!"
    click_button "Submit"

    click_link "Edit this post"
    fill_in "Message", with: "Bye, world!"
    click_button "Update post"
    
    expect(page).to have_content("Bye, world!")
  end

  scenario "User can't edit others' post" do
    user_sign_up

    visit "/posts"
    click_link "New post"
    fill_in "Message", with: "Hello, world!"
    click_button "Submit"

    click_link "Logout"

    user_sign_up("example2@example.com", "password2")
    
    click_link "Edit this post"
    fill_in "Message", with: "Bye, world!"
    click_button "Update post"
    
    expect(page).to have_content("Hello, world!")
  end
end
