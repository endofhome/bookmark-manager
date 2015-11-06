require_relative '../app/models/user'

describe User do 
  subject(:user) { described_class }
  let(:email) { 'incredible@yev.com' }
  let(:password) { 'bla-bla-bla' }

  it 'authenticates a user against a given password' do
    user.create(email: email,
                password: password,
                password_confirmation: password)
    expect(user.authenticate(email, password)).to be true
  end
end