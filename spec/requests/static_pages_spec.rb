require 'spec_helper'

describe "Static pages" do

  subject { page }

  shared_examples_for "all static pages" do
    it { should have_title(full_title(page_title)) }
  end

  it "should have the right links on the layout" do
    visit root_path
    click_link "Contact"
    expect(page).to have_title(full_title('Contact'))
    click_link "Music Training"
    expect(page).to have_title(full_title('Music Training'))
    click_link "Max Tietze Music"
    expect(page).to have_title(full_title(''))
    click_link "About"
    expect(page).to have_title(full_title('About'))
    click_link "Original Music"
    expect(page).to have_title(full_title('Original Music'))
  end

  describe "Home page" do
    before { visit root_path }
    let(:page_title) { '' }
    it_should_behave_like "all static pages"
  end

  describe "Contact" do
    before { visit contact_path }
    let(:page_title) { 'Contact' }
    it_should_behave_like "all static pages"
  end

  describe "Music Training" do
    before { visit music_training_path }
    let(:page_title) { 'Music Training' }
    it_should_behave_like "all static pages"
  end

  describe "Getting Started" do
    before { visit getting_started_path }
    let(:page_title) { 'Getting Started' }
    it_should_behave_like "all static pages"
  end

  describe "About" do
    before { visit about_path }
    let(:page_title) { 'About' }
    it_should_behave_like "all static pages"
  end

  describe "Songs" do
    before { visit songs_path }
    let(:page_title) { 'Original Music' }
    it_should_behave_like "all static pages"
  end
end
