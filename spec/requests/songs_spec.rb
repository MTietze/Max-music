require 'spec_helper'

describe "Songs" do
  
  subject { page }

  describe "Original Music page" do
    let!(:song) { FactoryGirl.create(:song) }
    let!(:newer_song) { FactoryGirl.create(:song, year: 2014, title: "ZZZ", artist: "ZZZ") }
    before { visit songs_path }
    
    it "should display songs in database" do
      expect(page).to have_content(song.artist) 
      expect(page).to have_link(song.title, href: download_url_for(song.filename)) 
      expect(page).to have_content(song.year) 
      expect(page).not_to have_content(song.filename)
      expect(page).not_to have_content(song.blurb) 
    end

    describe "sorting" do
      it "should display songs ordered by year" do 
        newer_song.title.should appear_before(song.title)
      end
      describe "by title" do 
        before { click_link "Title" }
        it "should sort rows by title" do
          song.title.should appear_before(newer_song.title)
        end
        it "should sort rows by title in reverse" do
          click_link "Title"
          newer_song.title.should appear_before(song.title)
        end
      end
      describe "by artist" do
        before { click_link "With" }
        it "should sort rows by artist" do
          song.title.should appear_before(newer_song.title)
        end
        it "should sort rows by artist in reverse" do
          click_link "With"
          newer_song.title.should appear_before(song.title)
        end
      end
      describe "by year" do
        before { click_link "Year" }
        it "should sort rows by reverse year" do
          song.title.should appear_before(newer_song.title)
        end
      end
    end
  end
end
