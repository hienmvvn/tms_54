module ApplicationHelper
  def full_title page_title = ""
    base_title = t "home_page.full_title"
    page_title.empty? ? base_title: "#{page_title} | #{base_title}"
  end

  def link_to_add_fields name, f, association
    new_object = f.object.class.reflect_on_association(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render "admin/subjects/" + association.to_s.singularize + "_fields", f: builder
    end
    link_to name, "#", class: "add_fields", data: {id: id, fields: fields.gsub("\n", "")}
  end

  def subject_notice user_subject
    if user_subject.finished?
      content_tag :div, t("notice.finished"), class: "label label-success"
    elsif user_subject.in_process?
      content_tag :div, t("notice.inprocess"), class: "label label-info"
    elsif user_subject.closed?
      content_tag :div, t("notice.close"), class: "label label-warning"
    else
      content_tag :div, t("notice.free"), class: "label label-warning"
    end
  end

  def course_notice user_course
    if user_course.finished?
      content_tag :div, t("notice.finished"), class: "label label-success"
    elsif user_course.in_process?
      content_tag :div, t("notice.inprocess"), class: "label label-info"
    elsif user_course.closed?
      content_tag :div, t("notice.close"), class: "label label-warning"
    else
      content_tag :div, t("notice.free"), class: "label label-warning"
    end
  end

  def count_task user_subject
    if user_subject.finished?
      content_tag :div,
        t("notice.count_task",
          task_done: user_subject.user_tasks.count,
          total_task: user_subject.subject.tasks.count),
        class: "label label-success"
    else
      content_tag :div,
        t("notice.count_task",
          task_done: user_subject.user_tasks.count,
          total_task: user_subject.subject.tasks.count),
        class: "label label-default"
    end
  end

  def avatar_for user
    if user.avatar.url.nil?
      gravatar_id = Digest::MD5::hexdigest user.email.downcase
      gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=350"
      image_tag gravatar_url, alt: user.name, 
        class: "img-responsive img-circle"
    else
      cl_image_tag user.avatar, alt: user.name, 
        class: "img-responsive img-circle"
    end
  end

  def notice_type type
    type == "danger" ? "red" : "green"  
  end
end
