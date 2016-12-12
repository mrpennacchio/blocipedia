# include RandomData

FactoryGirl.define do
  factory :wiki do
    title Faker::Hipster.sentence
    body Faker::Hipster.paragraphs(1) 
    private false
    user
  end
end
