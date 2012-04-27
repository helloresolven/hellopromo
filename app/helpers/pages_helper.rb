module PagesHelper
  def sample_tweet
    %Q{Just got a code for #YourApp from @#{username} 
    <a href="http://t.co/TxriNxmi" title="Link to your URL.">http://t.co/TxriNxmi</a><br> 
    &mdash; @some_new_user}.html_safe
  end
  
  def username
    return current_user.nickname if current_user
    "yourname"
  end
end
