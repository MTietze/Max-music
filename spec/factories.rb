FactoryGirl.define do
  factory :song do
    sequence(:title) { |n| "Song #{n}" }
    sequence(:filename) { |n| "#{n} Song#{n}.m4a" }
    year "2013"
    artist "Example"
    blurb "Blah blah etc."
  end
end