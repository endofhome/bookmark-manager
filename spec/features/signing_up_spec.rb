feature 'Signing up' do
  scenario 'User can sign up' do
    visit '/users/new'
    expect(page.status_code).to eq(200)
    fill_in :email, with: 'incredible@yev.com'
    fill_in :password, with: 'bla-bla-bla'
    click_button 'Sign up!'
    expect { sign_up }.to change(User, :count).by 1
    expect(page).to have_content('Welcome, incredible@yev.com')
    expect(User.first.email).to eq('incredible@yev.com')
  end
end