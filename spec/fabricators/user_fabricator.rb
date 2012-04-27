Fabricator(:user) do
  uid { sequence(:uid, 11111).to_s }
  name 'Test User'
  nickname 'test_user'
  token 'token'
  secret 'secret'
end
