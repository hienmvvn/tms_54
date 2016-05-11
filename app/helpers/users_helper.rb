module UsersHelper
  def user_course_status user_course
    if user_course.free?
      content_tag :div, user_course.course.title, class: "btn btn-default"
    elsif user_course.in_process?
      link_to course_path(user_course) do
        content_tag :div, user_course.course.title, class: "btn btn-success"
      end
    end
  end

  def user_subject_status user_subject
    if user_subject.free?
      content_tag :div, user_subject.subject.title, class: "btn btn-default"
    elsif user_subject.in_process?
      link_to("#") do
        content_tag :div, user_subject.subject.title, class: "btn btn-success"
      end
    end
  end
end
