require 'rails_helper'

RSpec.describe User, type: :model do
  it "has username set correctly" do
    user = User.new username:"Atte"
    expect(user.username).to eq("Atte")
  end

  it "is not saved without password" do
    user = User.create username:"Atte"
    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end

  it "is not saved with too short password" do
    user = User.create username:"Atte", password:"A12", password_confirmation: "A12"
    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end

  it "is not saved with invalid password" do
    user = User.create username: "Atte", password: "salasana", password_confirmation: "salasana"
  end

  describe "with a proper password" do
    let(:user) { FactoryBot.create(:user) }

    it "is saved" do
      expect(user).to be_valid
      expect(User.count).to eq(1)
    end

    it "has correct average rating with two ratings" do
      FactoryBot.create(:rating, score: 10, user: user)
      FactoryBot.create(:rating, score: 20, user: user)

      expect(user.ratings.count).to eq(2)
      expect(user.average_rating).to eq(15.0)
    end
  end
  describe "favourite beer" do
    let(:user) { FactoryBot.create(:user) }
    it "has a method for determining favourite_beer" do
      expect(user).to respond_to(:favourite_beer)
    end

    it "does not have one without ratings" do
      expect(user.favourite_beer).to be_nil
    end

    it "is the the only rated if only one rating" do
      beer = FactoryBot.create(:beer)
      rating = FactoryBot.create(:rating, score: 20, beer: beer, user: user)
      expect(user.favourite_beer).to eq(beer)
    end

    it "is the highest rated if multiple rated" do
      create_beers_with_many_ratings({user: user}, 15, 12, 3, 29, 28)
      best = create_beer_with_rating({user: user}, 30)

      expect(user.favourite_beer).to eq(best)
    end
  end

  describe "favourite style" do
    let(:user) { FactoryBot.create(:user) }

    it "has a method for favourite style" do
      expect(user).to respond_to(:favourite_style)
    end

    it "returns nil if no ratings" do
      expect(user.favourite_style).to be_nil
    end

    it "returns only beers style if only one beer rated" do
      beer = create_beer_with_rating({user: user}, 15)
      expect(user.favourite_style).to eq(beer.style)
    end
  end

  def create_beer_with_rating(object, score)

    beer = FactoryBot.create(:beer)
    FactoryBot.create(:rating, beer: beer, score: score, user: object[:user] )
    beer
  end

  def create_beers_with_many_ratings(object, *scores)
    scores.each do |score|
      create_beer_with_rating(object, score)
    end
  end
end
