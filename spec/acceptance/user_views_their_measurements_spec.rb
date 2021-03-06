require "spec_helper"

feature "User submits a reading" do
  let!(:user) { Fabricate(:user) }
  let!(:measurement) { Fabricate(:measurement, :user => user, :value => 10101) }
  
  before { sign_in(user) }

  scenario "First reading" do
    visit("/")
    click_link("Submissions")
    page.should have_content("10101")
  end

  scenario "Viewing a single measurement entry" do
    measurement.captured_at = nil
    measurement.save
    visit("/en-US/measurements/#{measurement.id}")
    find(".dl-horizontal > dd:nth-child(4)").should have_text("null")
  end
end
