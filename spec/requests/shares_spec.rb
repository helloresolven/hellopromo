require 'spec_helper'

describe "the creation process" do
  it "creates a new share if it all works" do
    visit("/signin")
    visit("/shares/new")
    
    within("#new_share") do
      fill_in "Title", :with => "Test"
      fill_in "URL", :with => "http://example.com/"
      fill_in "Description", :with => "t"
      fill_in "Codes", :with => "123\n456\n789\n\n012\n\n\n"
    end
    
    click_button("Create Share")
    
    page.should have_content "123"
    page.should have_content "456"
    page.should have_content "789"
    page.should have_content "012"
  end
end

describe "the redeeming process" do
  before {
    @share = Fabricate(:share)
  }
  
  it "shows if there are codes left" do
    visit("/signin")
    visit(share_path(@share))
    page.should have_content "Get A Code"
  end
  
  it "show if there are no codes left" do
    visit("/signin")
    
    @share.redeemables.each { |r| r.destroy }
    
    visit(share_path(@share))
    page.should have_content "No codes left"
  end
  
  it "reports the correct code after acquiring" do
    visit("/signin")    
    visit(share_path(@share))
    click_link("Get A Code")
    click_link("Get A Code!")
    
    code = @share.redeemed_codes.first.code
#    save_and_open_page
    page.should have_content "Your code is #{code}"
  end
  
  
end

