require 'rails_helper'

feature "displaying rank" do
	let(:hacker) {FactoryGirl.create(:hacker)}

	def fill_in_signin_fields
		click_button "Log in"
	end

	scenario "visiting the site to see rank" do
		visit root_path
		expect(page).to have_content("Signed in successfully.")
	end
end