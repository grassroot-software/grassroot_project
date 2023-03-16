module LessonsHelper
  def github_edit_url(lesson)
    github_link("grassroot_curriculum/edit/main#{lesson.github_path}")
  end
end
