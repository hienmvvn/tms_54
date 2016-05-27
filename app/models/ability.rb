class Ability
  include CanCan::Ability

  def initialize user
    user ||= User.new 
    if user.admin?
      can :manage, :all
    else
      can :read, course: {id: user.course_ids}      
      can :read, subject: {id: user.subject_ids}
      can [:read, :index], User, id: User.trainee.ids
      can :read, UserCourse, user_id: user.id
      can [:read, :update], UserSubject, user_id: user.id
      can :manage, Activity, user_id: user.id
    end
    if user.supervisor?
      can :read, User, id: User.supervisor.ids
      can [:update, :edit, :show, :index], Course, id: user.course_ids
      can [:update, :show], CourseSubject, course_id: user.course_ids
    end
  end
end
