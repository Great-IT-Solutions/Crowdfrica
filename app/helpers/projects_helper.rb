module ProjectsHelper
  def category_content_class(project_category_id, item_category_id)
    if project_category_id == item_category_id
      'show'
    else
      'hide'
    end
  end

  def category_checked(project_category_id, item_category_id)
    'checked' if project_category_id == item_category_id
  end
end
