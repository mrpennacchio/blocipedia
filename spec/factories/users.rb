# include RandomData

FactoryGirl.define do

  pw = "password"

  factory :user do
    name RandomData.random_name
    email RandomData.random_email
    password pw
    password_confirmation pw
  end

end
