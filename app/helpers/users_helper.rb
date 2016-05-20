module UsersHelper
  def user_course_status user_course
    if current_user.supervisor?
      link_to user_course.course.title,
        [:admin, user_course.course], class: "btn btn-primary"
    else
      if user_course.free? || user_course.closed?
        content_tag :div, user_course.course.title, class: "btn btn-default"
      elsif user_course.in_process?
        link_to user_course.course.title,
          user_course_path(user_course), class: "btn btn-primary"
      end
    end
  end

  def user_subject_status user_subject
    if user_subject.free? || user_subject.closed?
      content_tag :div, user_subject.subject.title, class: "btn btn-default"
    elsif user_subject.in_process?
      link_to user_subject.subject.title,
        user_subject_path(user_subject), class: "btn btn-primary"
    end
  end
end
