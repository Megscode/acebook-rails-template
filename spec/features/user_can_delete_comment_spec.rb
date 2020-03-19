require "rails_helper"

RSpec.feature "Timeline of comments", type: :feature do
  scenario "User can see the delete button" do
    user_sign_up

    visit "/posts"
    click_link "New post"
    fill_in "Message", with: "Hello, world!"
    click_button "Submit"

    click_link "Add comment"
    fill_in "Content", with: "This is a comment"
    click_button "Submit"
    visit "/posts"

    expect(page.all("#posts").first.text).to include("Delete")
  end

  scenario "User can delete their comment" do
    user_sign_up

    visit "/posts"
    click_link "New post"
    fill_in "Message", with: "Hello, world!"
    click_button "Submit"

    click_link "Add comment"
    fill_in "Content", with: "This is a comment"
    click_button "Submit"
    visit "/posts"
    click_link "Delete"
    expect(page.all("#posts").first.text).not_to include("This is a comment")
  end
end
