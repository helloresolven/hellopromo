Fabricator(:redeemable) do
  code { Faker::PhoneNumber.phone_number }
end
