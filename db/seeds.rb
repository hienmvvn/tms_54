Fabricate :user, name: "mai van hien", email: "hienmv94@gmail.com",
  password: "mrhien1994", role: 2
Fabricate :user, name: "phan tan", email: "phantan@gmail.com",
  password: "mrhien1994", role: 1
Fabricate :user, name: "hoang ngoc quy", email: "ngocquy@gmail.com",
  password: "mrhien1994", role: 0

4.times do
  subject = Fabricate :subject, title: Faker::Lorem.characters(10),
    description: Faker::Lorem.sentence(3) 
  4.times do 
    Fabricate :task, title: Faker::Lorem.characters(10), 
      description: Faker::Lorem.sentence(3), subject_id: subject.id
  end
  course = Fabricate :course, title: Faker::Lorem.characters(10),
    status: 1,  description: Faker::Lorem.sentence(3) 
end  
4.times do
  Fabricate :course_subject, course_id: 1,
    subject_id: Faker::Number.between(1, 4)
  Fabricate :user_course, status: Faker::Number.between(0, 1),
    user_id: 1, course_id: Faker::Number.between(1, 4)
  Fabricate :user_subject, status: Faker::Number.between(0, 1),
    user_id: 1, user_course_id: 1, subject_id: Faker::Number.between(1, 4)
end
