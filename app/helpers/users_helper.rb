module UsersHelper
  def course_status course
    if course.free?
      content_tag :div, course.title, class: "btn btn-default"
    end
    if course.in_process?
      link_to("#") do
        content_tag :div, course.title, class: "btn btn-success"
      end
    end
  end
end
