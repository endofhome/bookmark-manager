def sign_up(email: 'incredible@yev.com',
            password: 'bla-bla-bla',
            password_confirmation: 'bla-bla-bla')
  visit '/users/new'
  fill_in :email, with: email
  fill_in :password, with: password
  fill_in :password_confirmation, with: password_confirmation
  click_button 'Sign up!'
end  