feature 'Signing in' do
  scenario 'user can sign in' do
    sign_up
    sign_in
    expect(page).to have_content 'Welcome, incredible@yev.com'
  end

  scenario "can't sign in with wrong password" do
    sign_up
    sign_in_with_wrong_password
  expect(page).to have_content 'Bad password, Yev!'
  end
end