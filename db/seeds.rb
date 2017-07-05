# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Girl.create(name: "Kurosawa Dia", age: 17)
Girl.create(name: "Matsuura Kanan", age: 17)
Girl.create(name: "Ohara Mari", age: 18)

Girl.create(name: "Watanabe You", age: 17)
Girl.create(name: "Takami Chika", age: 17)
Girl.create(name: "Sakurauchi Riko", age: 17)

Girl.create(name: "Kunikida Hanamaru", age: 15)
Girl.create(name: "Kurosawa Ruby", age: 16)
Girl.create(name: "Tsushima Yoshiko", age: 16)

for i in 1..30 do
	user = User.create(email: Faker::Internet.email, password: Faker::Internet.password)

	rankings = (1..9).to_a.shuffle
	Girl.all.each do |girl|
		Ranking.create(girl: girl, user: user, rank: rankings[girl.id-1])
	end
end

User.all.each do |user|
	user.update_absolute_ranks_of_ranking
end