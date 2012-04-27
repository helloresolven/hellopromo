require 'spec_helper'

describe RedeemablesController do
  let!(:share) { Fabricate(:share) }
  let!(:alice) { Fabricate(:user) }
  let!(:bob) { Fabricate(:user) }
  let!(:clemence) { Fabricate(:user) }
  
  describe "GET acquire" do
    it "should let a user here if codes are still left and they have one." do
      get :acquire, {:id => share.to_param}, {user_id:alice.id}
      response.status.should eq 200
    end
    
    it "should not let a user here if they have one already" do
      code = share.unredeemed_codes.first
      code.redeemer = alice
      code.save
      
      get :acquire, {:id => share.to_param}, {user_id:alice.id}
      response.should redirect_to share_path(share)
      flash[:notice].should be_present
    end
    
    it "should not let a user here if all the codes are taken" do
      share.unredeemed_codes.each do |code|
        code.redeemer = bob
        unless code.save
          code.redeemer = clemence
          code.save
        end
      end
      
      get :acquire, {:id => share.to_param}, {user_id:alice.id}
      response.should redirect_to share_path(share)
      flash[:notice].should be_present
    end
    
    it "should not let the owner redeem a code" do
      get :acquire, {:id => share.to_param}, {user_id:share.owner.id}
      response.should redirect_to share_path(share)
      flash[:notice].should be_present
    end
  end
  
  describe "POST redeem" do
    it "shouldn't assign a code to the owner of the share" do
      expect { 
        post :redeem, {:id => share.to_param}, {user_id:share.owner.id}
        response.should redirect_to share_path(share)
      }.to change(share.redeemed_codes, :count).by(0)
    end
    
    it "shouldn't assign a code to someone who already has one" do
      code = share.unredeemed_codes.first
      code.redeemer = alice
      code.save
      
      expect { 
        post :redeem, {:id => share.to_param}, {user_id:alice.id}
        response.should redirect_to share_path(share)
      }.to change(share.redeemed_codes, :count).by(0)
    end
    
    it "shouldn't assign a code if there are none left" do
      share.unredeemed_codes.each do |code|
        code.redeemer = bob
        unless code.save
          code.redeemer = clemence
          code.save
        end
      end
            
      expect { 
        post :redeem, {:id => share.to_param}, {user_id:alice.id}
        response.should redirect_to share_path(share)
      }.to change(share.redeemed_codes, :count).by(0)
    end
    
    it "should otherwise assign a code" do
      code = share.unredeemed_codes.first
      code.redeemer = bob
      code.save
      
      expect { 
        post :redeem, {:id => share.to_param}, {user_id:alice.id}
        response.should redirect_to share_path(share)
      }.to change(share.redeemed_codes, :count).by(1)
    end
  end
end
