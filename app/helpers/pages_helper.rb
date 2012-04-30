module PagesHelper
  def sample_tweet
    %Q{Just got a code for #ATotallyCoolApp from @some_developer 
    <a href="http://example.com/" title="Link to your URL.">http://example.com/</a>}.html_safe
  end
end
