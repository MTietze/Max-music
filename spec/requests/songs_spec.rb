require 'spec_helper'
require 'pp'

describe "Songs" do
  
  subject { page }

  describe "Original Music page" do
    let!(:song) { FactoryGirl.create(:song) }
    before { visit songs_path }
    it { should have_title "Music World | Original Music"} 
    
    it "should display songs in database" do
      expect(page).to have_content(song.artist) 
      expect(page).to have_link(song.title, href: download_url_for(song.filename)) 
      expect(page).to have_content(song.year) 
      expect(page).not_to have_content(song.filename)
      expect(page).not_to have_content(song.blurb) 
    end
      specify "display blurb", js: true do
        page.find('tr').trigger(:mouseover)
        expect(page).to have_content(song.blurb) 
    end
  end
end
