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

  scenario 'requires a matching confirmation password' do
    expect { sign_up(password_confirmation: 'wrong') }.not_to change(User, :count)
    expect(current_path).to eq ('/users')
    expect(page).to have_content 'Password and confirmation password do not match'
  end

  def sign_up(email: 'incredible@yev.com',
            password: 'bla-bla-bla',
            password_confirmation: 'bla-bla-bla')
    visit '/users/new'
    fill_in :email, with: email
    fill_in :password, with: password
    fill_in :password_confirmation, with: password_confirmation
    click_button 'Sign up!'
  end 
end

