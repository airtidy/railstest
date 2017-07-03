require 'rails_helper'

RSpec.describe Ranking, type: :model do
	it "has valid factory" do
		expect(FactoryGirl.create(:ranking)).to be_valid
	end

	it "can calculate site-wide rankings correctly (With one single user)" do
		girl1 = FactoryGirl.create(:girl, name:"Girl A", age: 17)
		girl2 = FactoryGirl.create(:girl, name:"Girl B", age: 18)
		girl3 = FactoryGirl.create(:girl, name:"Girl C", age: 19)

		user = FactoryGirl.create(:user)

		FactoryGirl.create(:ranking, user: user, girl: girl1, rank: 1)
		FactoryGirl.create(:ranking, user: user, girl: girl2, rank: 2)
		FactoryGirl.create(:ranking, user: user, girl: girl3, rank: 3)

		verify = Ranking::global_ranking
		expect(verify[0][:name]).to eql("Girl A")
		expect(verify[1][:name]).to eql("Girl B")
		expect(verify[2][:name]).to eql("Girl C")
	end

	it "can calculate site-wide rankings correctly (With three users \
	    and all ranks the same)" do

		girl1 = FactoryGirl.create(:girl, name:"Girl A", age: 17)
		girl2 = FactoryGirl.create(:girl, name:"Girl B", age: 18)
		girl3 = FactoryGirl.create(:girl, name:"Girl C", age: 19)

		user1 = FactoryGirl.create(:user)
		user2 = FactoryGirl.create(:user)
		user3 = FactoryGirl.create(:user)

		FactoryGirl.create(:ranking, user: user1, girl: girl1, rank: 1)
		FactoryGirl.create(:ranking, user: user1, girl: girl2, rank: 2)
		FactoryGirl.create(:ranking, user: user1, girl: girl3, rank: 3)

		FactoryGirl.create(:ranking, user: user2, girl: girl1, rank: 1)
		FactoryGirl.create(:ranking, user: user2, girl: girl2, rank: 2)
		FactoryGirl.create(:ranking, user: user2, girl: girl3, rank: 3)

		FactoryGirl.create(:ranking, user: user3, girl: girl1, rank: 1)
		FactoryGirl.create(:ranking, user: user3, girl: girl2, rank: 2)
		FactoryGirl.create(:ranking, user: user3, girl: girl3, rank: 3)

		verify = Ranking::global_ranking
		expect(verify[0][:name]).to eql("Girl A")
		expect(verify[1][:name]).to eql("Girl B")
		expect(verify[2][:name]).to eql("Girl C")
	end

	it "can calculate site-wide rankings correctly (With three users\
	    and all ranks the same) case 2" do

		girl1 = FactoryGirl.create(:girl, name:"Girl A", age: 17)
		girl2 = FactoryGirl.create(:girl, name:"Girl B", age: 18)
		girl3 = FactoryGirl.create(:girl, name:"Girl C", age: 19)

		user1 = FactoryGirl.create(:user)
		user2 = FactoryGirl.create(:user)
		user3 = FactoryGirl.create(:user)

		FactoryGirl.create(:ranking, user: user1, girl: girl1, rank: 3)
		FactoryGirl.create(:ranking, user: user1, girl: girl2, rank: 1)
		FactoryGirl.create(:ranking, user: user1, girl: girl3, rank: 2)

		FactoryGirl.create(:ranking, user: user2, girl: girl1, rank: 3)
		FactoryGirl.create(:ranking, user: user2, girl: girl2, rank: 1)
		FactoryGirl.create(:ranking, user: user2, girl: girl3, rank: 2)

		FactoryGirl.create(:ranking, user: user3, girl: girl1, rank: 3)
		FactoryGirl.create(:ranking, user: user3, girl: girl2, rank: 1)
		FactoryGirl.create(:ranking, user: user3, girl: girl3, rank: 2)

		verify = Ranking::global_ranking
		expect(verify[0][:name]).to eql("Girl B")
		expect(verify[1][:name]).to eql("Girl C")
		expect(verify[2][:name]).to eql("Girl A")
	end

	it "can calculate site-wide rankings correctly (With 5 users \
	    and all ranks differently)" do

		girl1 = FactoryGirl.create(:girl, name:"Girl A", age: 17)
		girl2 = FactoryGirl.create(:girl, name:"Girl B", age: 18)
		girl3 = FactoryGirl.create(:girl, name:"Girl C", age: 19)

		user1 = FactoryGirl.create(:user)
		user2 = FactoryGirl.create(:user)
		user3 = FactoryGirl.create(:user)
		user4 = FactoryGirl.create(:user)
		user5 = FactoryGirl.create(:user)

		FactoryGirl.create(:ranking, user: user1, girl: girl1, rank: 1)
		FactoryGirl.create(:ranking, user: user1, girl: girl2, rank: 2)
		FactoryGirl.create(:ranking, user: user1, girl: girl3, rank: 3)

		FactoryGirl.create(:ranking, user: user2, girl: girl1, rank: 1)
		FactoryGirl.create(:ranking, user: user2, girl: girl2, rank: 3)
		FactoryGirl.create(:ranking, user: user2, girl: girl3, rank: 2)

		FactoryGirl.create(:ranking, user: user3, girl: girl1, rank: 2)
		FactoryGirl.create(:ranking, user: user3, girl: girl2, rank: 3)
		FactoryGirl.create(:ranking, user: user3, girl: girl3, rank: 1)

		FactoryGirl.create(:ranking, user: user4, girl: girl1, rank: 1)
		FactoryGirl.create(:ranking, user: user4, girl: girl2, rank: 3)
		FactoryGirl.create(:ranking, user: user4, girl: girl3, rank: 2)

		FactoryGirl.create(:ranking, user: user5, girl: girl1, rank: 2)
		FactoryGirl.create(:ranking, user: user5, girl: girl2, rank: 3)
		FactoryGirl.create(:ranking, user: user5, girl: girl3, rank: 1)

		verify = Ranking::global_ranking
		expect(verify[0][:name]).to eql("Girl A")
		expect(verify[1][:name]).to eql("Girl C")
		expect(verify[2][:name]).to eql("Girl B")
	end

	it "calculates site-wide rankings correctly (With 5 users \
	    and some user did not rank all)" do

		girl1 = FactoryGirl.create(:girl, name:"Girl A", age: 17)
		girl2 = FactoryGirl.create(:girl, name:"Girl B", age: 18)
		girl3 = FactoryGirl.create(:girl, name:"Girl C", age: 19)

		user1 = FactoryGirl.create(:user)
		user2 = FactoryGirl.create(:user)
		user3 = FactoryGirl.create(:user)
		user4 = FactoryGirl.create(:user)
		user5 = FactoryGirl.create(:user)

		FactoryGirl.create(:ranking, user: user1, girl: girl1, rank: 1)
		FactoryGirl.create(:ranking, user: user1, girl: girl2, rank: 2)
		FactoryGirl.create(:ranking, user: user1, girl: girl3, rank: 3)

		FactoryGirl.create(:ranking, user: user2, girl: girl1, rank: 1)
		FactoryGirl.create(:ranking, user: user2, girl: girl2, rank: 3)
		FactoryGirl.create(:ranking, user: user2, girl: girl3, rank: 2)

		FactoryGirl.create(:ranking, user: user3, girl: girl2, rank: 1)
		FactoryGirl.create(:ranking, user: user3, girl: girl3, rank: 2)

		FactoryGirl.create(:ranking, user: user4, girl: girl1, rank: 2)
		FactoryGirl.create(:ranking, user: user4, girl: girl3, rank: 1)

		FactoryGirl.create(:ranking, user: user5, girl: girl2, rank: 1)

		verify = Ranking::global_ranking
		expect(verify[0][:name]).to eql("Girl A")
		expect(verify[1][:name]).to eql("Girl B")
		expect(verify[2][:name]).to eql("Girl C")
	end
	
end
