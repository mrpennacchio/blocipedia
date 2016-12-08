require 'rails_helper'
include RandomData

RSpec.describe Wiki, type: :model do
  # create user and wiki for test
  let(:user) { User.create!(name: "user name", email: "username@example.com", password: "helloworld") }
  let(:wiki) { Wiki.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph, user: user) }

  # wiki should belong to a user
  it { is_expected.to belong_to(:user) }

  # presence validations: title, body, user
  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of(:body) }

  # validate length of title and body
  it { is_expected.to validate_length_of(:title).is_at_least(5) }
  it { is_expected.to validate_length_of(:body).is_at_least(20) }


  describe "attributes" do
    it "has a title and body attribute" do
      expect(wiki).to have_attributes(title: wiki.title, body: wiki.body)
    end
  end

end
