require 'spec_helper'

describe "Ear Training" do
  
  subject { page }

  describe "Ear training page" do
    before { visit ear_training_path }
    it { should have_title "Music World | Ear Training"} 
    
    it "should display buttons" do
      expect(page).to have_link "playNote"
      expect(page).to have_link "next"
    end
  end
end
