crumb :root do
  link "<i class='fas fa-fw fa-home'></i> Trang chủ".html_safe, root_path
end

crumb :posts do
  link "Tất cả tin tức", posts_path
end

crumb :bookmarks do
  link "Tin đã lưu", bookmarks_path
end

crumb :youtube_videos do
  link "Videos", bookmarks_path
end

crumb :categories do
  link "Danh mục"
end

crumb :category do |category|
  link category.name, category
  parent :categories
end

crumb :sources do
  link "Nguồn tin"
end

crumb :source do |source|
  link source.name, source
  parent :sources
end

# crumb :projects do
#   link "Projects", projects_path
# end

# crumb :project do |project|
#   link project.name, project_path(project)
#   parent :projects
# end

# crumb :project_issues do |project|
#   link "Issues", project_issues_path(project)
#   parent :project, project
# end

# crumb :issue do |issue|
#   link issue.title, issue_path(issue)
#   parent :project_issues, issue.project
# end

# If you want to split your breadcrumbs configuration over multiple files, you
# can create a folder named `config/breadcrumbs` and put your configuration
# files there. All *.rb files (e.g. `frontend.rb` or `products.rb`) in that
# folder are loaded and reloaded automatically when you change them, just like
# this file (`config/breadcrumbs.rb`).