require 'rails_helper'
include RandomData

RSpec.describe User, type: :model do
   let(:user) { User.create!(name: "user name", email: "username@example.com", password: "helloworld") }

   # tests for name
   it { is_expected.to validate_presence_of(:name) }
   it { is_expected.to validate_length_of(:name).is_at_least(1) }

   # tests for email
   it { is_expected.to validate_presence_of(:email) }
   it { is_expected.to validate_uniqueness_of(:email) }
   it { is_expected.to validate_length_of(:email).is_at_least(3) }
   it { is_expected.to allow_value("username@example.com").for(:email) }

   # test for password
   it { is_expected.to validate_presence_of(:password) }
   it { is_expected.to validate_length_of(:password).is_at_least(6) }

   # attributes for valid user
   describe "attributes" do
     it "should have name, email, and password attributes" do
       expect(user).to have_attributes(name: "user name", email: "username@example.com", password: "helloworld")
     end
   end

   describe "invalid user" do
     let(:user_with_invalid_name) { User.new(name: "", email: "username@example.com") }
     let(:user_with_invalid_email) { User.new(name: "user name", email:"") }

     it "should be an invalid user if name is empty" do
       expect(user_with_invalid_name).to_not be_valid
     end

     it "should be an invalid user if email is empty" do
       expect(user_with_invalid_email).to_not be_valid
     end
   end

end
