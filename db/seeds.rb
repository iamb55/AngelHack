# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

mentors = [
  {
    first_name: "Brennen",
    last_name: "Byrne",
    birthday: "12/08/1990",
    email: "test@example.com",
    picture_url: "http://placekitten.com/50/50",
    password: "password",
    password_confirmation: "password"
  },
  {
    first_name: "Conway",
    last_name: "Anderson",
    birthday: "2/10/1987",
    email: "test2@example.com",
    picture_url: "http://placekitten.com/50/50",
    password: "password",
    password_confirmation: "password"
  },
  {
    first_name: "Test",
    last_name: "User",
    birthday: "02/04/1989",
    email: "test3@example.com",
    picture_url: "http://placekitten.com/50/50",
    password: "password",
    password_confirmation: "password"
  }
].collect {|data| Mentor.create(data) }

mentees = [
  {
    first_name: "Jesse",
    last_name: "Pollak",
    email: "test4@example.com",
    picture_url: "http://placekitten.com/50/50",
    birthday: "11/21/1992",
    password: "password",
    password_confirmation: "password"
  },
  {
    first_name: "Jordan",
    last_name: "Goldstein",
    email: "test5@example.com",
    picture_url: "http://placekitten.com/50/50",
    birthday: "5/26/1994",
    password: "password",
    password_confirmation: "password"
  },
  {
    first_name: "Cheryl",
    last_name: "Wu",
    email: "test6@example.com",
    picture_url: "http://placekitten.com/50/50",
    birthday: "08/21/1993",
    password: "password",
    password_confirmation: "password"
  }
].collect {|data| Mentee.create(data) }

# mentees.each {|m| m.confirm!}
# mentors.each {|m| m.confirm!} 

conversations = []
(0..2).each do |i|
  mentee = mentees[i]
  (0..2).each do |j|
    c = mentee.conversations.build
    c.mentor = mentors[j]
    c.save
    conversations << c
  end
end

# mentees.each do |mentee| 
#   c = mentee.conversations.build
#   c.save
#   m = c.messages.build
#   m.owner_type = 'mentee'
#   m.text = "Look, just because I don't be givin' no man a foot massage don't make it right for Marsellus to throw Antwone into a glass motherfuckin' house, fuckin' up the way the nigger talks. Motherfucker do that shit to me, he better paralyze my ass, 'cause I'll kill the motherfucker, know what I'm sayin'?"
#   m.save
# end
  
conversations.each do |conversation|
  (0..9).each do |i|
    m = conversation.messages.build
    if i % 2 == 0
      m.owner_type = "mentor"
    else
      m.owner_type = "mentee"
    end
    
    m.text = "Look, just because I don't be givin' no man a foot massage don't make it right for Marsellus to throw Antwone into a glass motherfuckin' house, fuckin' up the way the nigger talks. Motherfucker do that shit to me, he better paralyze my ass, 'cause I'll kill the motherfucker, know what I'm sayin'?"
    m.save
  end
end

tags = ["Analytics", "Ballpark Figure", "Bandwidth", "Business-to-Business", "Business-to-Consumer", "Best practices", "Business Process Outsourcing", "Buzzword compliant", "Co-opetition", "Core competency", "Downsizing", "Drinking the Kool-Aid", "Eating your own dogfood", "Entitlement", "Event horizon", "Herding cats", "Holistic", "Knowledge Process Outsourcing", "Logistics", "Long Tail", "Mission Critical", "Next generation", "Offshoring", "Return on Investment", "Reverse fulfilment", "Seamless", "integration", "Sarbanes-Oxley", "Sustainability"]

mentors.each do |mentor|
  mentor.add_tags(tags.sample(5))
end

mentee = Mentee.create({first_name: "Bob", last_name: "Dale", email: "bobdale@test.com", picture_url: "http://placekitten.com/50/50", birthday: "10/22/50", password: "password", password_confirmation: "password"})

mentor = Mentor.create({first_name: "Jim", last_name: "Yelp", email: "jimyelp@test.com", picture_url: "http://placekitten.com/50/50", birthday: "10/17/50", password: "password", password_confirmation: "password"})

c = mentee.conversations.build
c.mentor = mentor
c.save

m = c.messages.build
m.owner_type = "mentee"
m.text = "Can you answer my question?"
m.save
