class Ability
  include CanCan::Ability

  def initialize user
    user ||= User.new 
    if user.admin?
      can :manage, :all
    else
      can :read, course: {id: user.course_ids}      
      can :read, subject: {id: user.subject_ids}
      can :read, User, id: user.id
      can :read, UserCourse, user_id: user.id
      can :read, UserSubject, user_id: user.id
    end
  end
end
