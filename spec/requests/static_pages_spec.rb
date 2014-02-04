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
    click_link "Theory Training"
    expect(page).to have_title(full_title('Theory Training'))
    click_link "Ear Training"
    expect(page).to have_title(full_title('Ear Training'))
    click_link "Max Tietze Music World"
    expect(page).to have_title(full_title(''))
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

  describe "Theory Training" do
    before { visit theory_path }
    let(:page_title) { 'Theory Training' }
    it_should_behave_like "all static pages"
  end

  describe "Ear Training" do
    before { visit ear_training_path }
    let(:page_title) { 'Ear Training' }
    it_should_behave_like "all static pages"
  end
end

  # describe "Home page" do
  #   before { visit root_path }
  #   let(:heading)    { 'Rails Social'}
  #   let(:page_title) { '' }
 
  #   it_should_behave_like "all static pages"
  #   it { should_not have_title('| Home') }
  #   