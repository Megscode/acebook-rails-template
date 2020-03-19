require 'rails_helper'

RSpec.feature "Timeline", type: :feature do
  scenario "Can submit comments and view them" do
    user_sign_up

    visit "/posts"
    click_link "New post"
    fill_in "Message", with: "Hello, world!"
    click_button "Submit"
    
    click_link "Add comment"
    fill_in "Content", with: "Comment on post"
    click_button "Submit"
    visit "/posts"

    expect(page).to have_content("Comment on post")
  end
end