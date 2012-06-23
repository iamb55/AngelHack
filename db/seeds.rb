# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

mentors = Mentor.create([
  {
    first_name: "Brennen",
    last_name: "Byrne",
    birthday: "12/08/1990",
    email: "test@example.com",
    picture_url: "http://placekittens.com/50/50"
  },
  {
    first_name: "Conway",
    last_name: "Anderson",
    birthday: "2/10/1987",
    email: "test@example.com",
    picture_url: "http://placekittens.com/50/50"
  },
  {
    first_name: "Test",
    last_name: "User",
    birthday: "02/04/1989",
    email: "test@example.com",
    picture_url: "http://placekittens.com/50/50"
  }
])

mentees = Mentee.create([
  {
    first_name: "Jesse",
    last_name: "Pollak",
    email: "test@example.com",
    picture_url: "http://placekittens.com/50/50",
    birthday: "11/21/1992"
  },
  {
    first_name: "Jordan",
    last_name: "Goldstein",
    email: "test@example.com",
    picture_url: "http://placekittens.com/50/50",
    birthday: "5/26/1994"
  },
  {
    first_name: "Cheryl",
    last_name: "Wu",
    email: "test@example.com",
    picture_url: "http://placekittens.com/50/50",
    birthday: "08/21/1993"
  }
])

conversations = []
(0..2).each do |i|
  (0..2).each do |j|
    c = mentees[i].conversations.build
    c.mentor = mentors[j]
    c.save
    conversations << c
  end
end

conversations.each do |conversation|
  (0..9).each do |i|
    m = conversation.messages.build
    if i % 2 == 0
      m.owner_type = "mentor"
    else
      m.owner_type = "mentee"
    end
    
    m.value = "Look, just because I don't be givin' no man a foot massage don't make it right for Marsellus to throw Antwone into a glass motherfuckin' house, fuckin' up the way the nigger talks. Motherfucker do that shit to me, he better paralyze my ass, 'cause I'll kill the motherfucker, know what I'm sayin'?"
  end
end
