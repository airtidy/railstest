require 'rails_helper'

RSpec.describe Nesoberi, type: :model do
	it "has valid factory" do
		expect(FactoryGirl.create(:nesoberi)).to be_valid
	end

  describe '.global_ranking' do
    it "does not repeat nesoberis in the global ranking" do
      Nesoberi.create(name: "Kurosawa Dia", age: 17)
      Nesoberi.create(name: "Matsuura Kanan", age: 17)
      Nesoberi.create(name: "Ohara Mari", age: 18)

      Nesoberi.create(name: "Watanabe You", age: 17)
      Nesoberi.create(name: "Takami Chika", age: 17)
      Nesoberi.create(name: "Sakurauchi Riko", age: 17)

      Nesoberi.create(name: "Kunikida Hanamaru", age: 15)
      Nesoberi.create(name: "Kurosawa Ruby", age: 16)
      Nesoberi.create(name: "Tsushima Yoshiko", age: 16)

      for i in 1..30 do
        user = User.create(email: Faker::Internet.email, password: Faker::Internet.password)

        rankings = (1..9).to_a.shuffle
        Nesoberi.all.each do |nesoberi|
          Ranking.create(nesoberi: nesoberi, user: user, rank: rankings[nesoberi.id-1])
        end
      end

      gr = described_class.global_ranking
      expect(gr.length).to eq gr.uniq.length
    end
  end

  describe 'Associations' do
    it 'has many rankings' do
      assc = described_class.reflect_on_association(:rankings)
      expect(assc.macro).to eq :has_many
    end
  end
end
