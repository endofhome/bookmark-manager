feature 'Sign out' do
  scenario 'User signs out' do
    sign_up
    sign_in
    sign_out
    expect(page).to have_content 'Goodbye, incredible@yev.com'
    expect(page).not_to have_content 'Welcome, incredible@yev.com'
  end
end
