def sign_up
  visit '/users/new'
  fill_in :email, with: 'incredible-yev@gmail.com'
  fill_in :password, with: 'bla-bla-bla'    
  click_button 'Sign up!'
end