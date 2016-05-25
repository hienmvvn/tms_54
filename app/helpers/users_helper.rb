module UsersHelper
  def user_course_status user_course
    if current_user.supervisor?
      link_to user_course.course.title,
        [:admin, user_course.course], class: "btn btn-primary"
    else
      if user_course.finished?
        link_to user_course.course.title,
          user_course_path(user_course), class: "btn btn-success"
      elsif user_course.free?
        content_tag :div, user_course.course.title, class: "btn btn-default"
      elsif user_course.in_process?
        link_to user_course.course.title,
          user_course_path(user_course), class: "btn btn-primary"
      else
        link_to user_course.course.title,
          user_course_path(user_course), class: "btn btn-warning"
      end
    end
  end

  def user_subject_status user_subject
    if user_subject.finished?
      link_to user_subject.subject.title,
        user_subject_path(user_subject), class: "btn btn-success"
    elsif user_subject.free?
      content_tag :div, user_subject.subject.title, class: "btn btn-default"
    elsif user_subject.in_process?
      link_to user_subject.subject.title,
        user_subject_path(user_subject), class: "btn btn-primary"
    else
      link_to user_subject.subject.title,
        user_subject_path(user_subject), class: "btn btn-warning"
    end
  end

  def activity_action activity
    if activity.update_profile?
      content_tag :div, t("activity.update_profile",
        time: time_ago_in_words(activity.created_at))
    elsif activity.follow?
      following_user = User.find_by id: activity.target_id
      content_tag :div, t("activity.follow_html", 
        user: link_to(following_user.name,
          user_path(following_user),
          class: "label label-info"),
        time: time_ago_in_words(activity.created_at))
    elsif activity.unfollow?
      unfollow_user = User.find_by id: activity.target_id
      content_tag :div, t("activity.unfollow_html",
        user: link_to(unfollow_user.name, 
          user_path(unfollow_user),
          class: "label label-info"),
        time: time_ago_in_words(activity.created_at))
    elsif activity.finish_task?
      user_task = UserTask.find_by id: activity.target_id
      content_tag :div, t("activity.finish_task_html",
        user: link_to(activity.user.name, activity.user),
        task: link_to(user_task.task.title, user_task.user_subject, 
          class: "label label-info"),
        time: time_ago_in_words(activity.created_at))
    elsif activity.finish_subject?
      user_subject = UserSubject.find_by id: activity.target_id
      content_tag :div, t("activity.finish_subject_html", 
        user: link_to(activity.user.name, activity.user),
        subject: link_to(user_subject.subject.title, user_subject,
          class: "label label-info"),
        time: time_ago_in_words(activity.created_at))
    else activity.finish_course?
      user_course = UserCourse.find_by id: activity.target_id
      content_tag :div, t("activity.finish_course_html",
        user: link_to(activity.user.name, activity.user),
        course: link_to(user_course.course.title, user_course,
          class: "label label-info"),
        time: time_ago_in_words(activity.created_at))
    end        
  end
end
