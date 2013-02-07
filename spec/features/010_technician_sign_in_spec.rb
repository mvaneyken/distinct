require 'spec_helper'

describe 'features' do

  describe 'technician sign in' do
    before(:each) do
      @technician = create(:technician)
      visit new_technician_session_path
      fill_in 'Email', :with => @technician.email
      fill_in 'Password', :with => "secret_password"
      click_button "Sign in"
    end
    it { page.should have_content "Signed in successfully" }
  end

end