module ApplicationHelper
  def date_format(datetime)
    if time_ago_in_words(datetime).end_with?("以内")
      return time_ago_in_words(datetime)
    else
      return time_ago_in_words(datetime) + '前'
    end
  end

  def return_children(comment, all_comments)
    comment_id = comment.id
    children_comments = @comments.where(parent_comment_id: comment_id)
    return children_comments
  end

  #link_toの引数で使うためのヘルパー
  def videofilter(videos)
    videos.each do |video|
    end
  end

  def filter
    if controller.action_name == 'hour' ||
      controller.action_name == 'today' ||
      controller.action_name == 'week' ||
      controller.action_name == 'month'||
      controller.action_name == 'year' ||
      controller.action_name == 'up' ||
      controller.action_name == 'count'
    end
  end
end
