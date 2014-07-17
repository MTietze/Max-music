require 'spec_helper'

describe "Music Training" do
  
  subject { page }

  describe "Ear training page" do
    before { visit music_training_path }
    
    it "should display buttons" do
      expect(page).to have_button "Intervals"
      expect(page).to have_button "Chords"
      expect(page).to have_button "Scales"
    end
  end
end
