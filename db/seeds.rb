Fabricate :user, name: "mai van hien", email: "hienmv94@gmail.com",
  password: "mrhien1994", role: 2
4.times do
  Fabricate :user, name: Faker::Name.name, email: Faker::Internet.free_email,
    password: Faker::Internet.password(8), role: Faker::Number.between(0, 2)
end

10.times do
  subject = Fabricate :subject, title: Faker::Lorem.characters(10),
    description: Faker::Lorem.sentence(3) 
  4.times do 
    Fabricate :task, title: Faker::Lorem.characters(10), 
      description: Faker::Lorem.sentence(3), subject_id: subject.id
  end
  course = Fabricate :course, title: Faker::Lorem.characters(10),
    status: Faker::Number.between(0, 2),  description: Faker::Lorem.sentence(3) 
end  
10.times do
  Fabricate :course_subject, course_id: Faker::Number.between(0, 9),
    subject_id: Faker::Number.between(0, 9)
  Fabricate :user_course, status: Faker::Number.between(0, 1),
    user_id: Faker::Number.between(0, 4), course_id: Faker::Number.between(0, 9)
end
