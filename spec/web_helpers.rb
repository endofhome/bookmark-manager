def sign_up(email: 'incredible@yev.com',
            password: 'bla-bla-bla',
            password_confirmation: 'bla-bla-bla')
  visit '/users/new'
  fill_in :email, with: email
  fill_in :password, with: password
  fill_in :password_confirmation, with: password_confirmation
  click_button 'Sign up!'
end

def sign_in
  visit '/sessions/new'
  fill_in :email, with: 'incredible@yev.com'
  fill_in :password, with: 'bla-bla-bla'
  click_button 'Sign in'  
end

def sign_in_with_wrong_password
  visit '/sessions/new'
  fill_in :email, with: 'incredible@yev.com'
  fill_in :password, with: 'the-yev'
  click_button 'Sign in'  
end  