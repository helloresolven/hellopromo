Fabricator(:share) do
  title "GIF Brewery"
  url "http://www.helloresolven.com/portfolio/gifbrewery/"
  share_code "gifbrew"
  need_tweet false
  promoted true
  redeemables!(:count => 2)
  owner! { Fabricate(:user) }
end
