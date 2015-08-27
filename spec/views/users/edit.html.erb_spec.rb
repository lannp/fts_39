RSpec.describe User, "Edit profile" do
  feature "Show user profile" do
    let!(:user) {FactoryGirl.create :user}

    before do
      visit "login"      
      fill_in "Email", with: user.email
      fill_in "Password", with: user.password
      click_button "Log in"
      click_link "Account"
      click_link "Settings"
    end

    scenario "Edit profile successfuly" do
      fill_in "Name", with: user.name
      fill_in "Email", with: user.email
      fill_in "Password", with: "12345678"
      fill_in "Confirm password", with: "12345678"
      click_button "Save Changes"

      expect(page).to have_content "Profile updated"
    end 

    scenario "Fail to edit profile if email is blank" do
      fill_in "Name", with: user.name
      fill_in "Email", with: ""
      fill_in "Password", with: user.password
      fill_in "Confirm password", with: user.password
      click_button "Save Changes"

      expect(page).to have_content "Update failed"
      expect(page).to have_content "Email can't be blank"
    end

    scenario "Fail to update profile if password is blank" do
      fill_in "Name", with: user.name
      fill_in "Email", with: user.email
      fill_in "Password", with: ""
      click_button "Save Changes"

      expect(page).to have_content "Update failed"
      expect(page).to have_content "Password can't be blank"
    end

    scenario "Fail to edit profile if password and password confirmation doesn't match" do
      fill_in "Name", with: user.name
      fill_in "Email", with: user.password
      fill_in "Password", with: user.password
      fill_in "Confirm password", with: "1111111111"
      click_button "Save Changes"
      
      expect(page).to have_content "Update failed"
      expect(page).to have_content "Password confirmation doesn't match Password"
    end
  end
end
