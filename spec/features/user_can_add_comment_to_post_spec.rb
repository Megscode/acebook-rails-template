require "rails_helper"

RSpec.feature "Timeline", type: :feature do
  include ActiveSupport::Testing::TimeHelpers

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

  scenario "Can see who commented and when" do
    user_sign_up
    travel_to Time.zone.local(2020, 3, 12, 00, 00, 00)

    visit "/posts"
    click_link "New post"
    fill_in "Message", with: "Hello, world!"
    click_button "Submit"

    click_link "Add comment"
    fill_in "Content", with: "Comment on post"
    click_button "Submit"
    visit "/posts"

    expect(page).to have_content("by example@example.com")
    expect(page).to have_content("2020-03-12 00:00:00 UTC")
  end
end
