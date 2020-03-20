require "rails_helper"

RSpec.feature "posts list with comments", type: :feature do
  scenario "User can see edit button" do
    user_sign_up

    visit "/posts"
    click_link "New post"
    fill_in "Message", with: "Hello, world!"
    click_button "Submit"

    click_link "Add comment"
    fill_in "Content", with: "Comment on post"
    click_button "Submit"
    visit "/posts"
    expect(page.all("#posts").first.text).to include("Update comment")
  end

  scenario "User can edit their comment" do
    user_sign_up

    visit "/posts"
    click_link "New post"
    fill_in "Message", with: "Hello, world!"
    click_button "Submit"

    click_link "Add comment"
    fill_in "Content", with: "Comment on post"
    click_button "Submit"

    # visit "/posts"
    click_link "Update comment"
    fill_in "Content", with: "Bye, sheep!"
    click_button "Update comment"
    
    expect(page.all("#posts").first.text).to include("Bye, sheep!")
  end
end
