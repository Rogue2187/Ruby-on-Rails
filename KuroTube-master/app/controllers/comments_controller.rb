class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    @comment.save
    @post_time_word = view_context.date_format(@comment.created_at).to_s
    if @comment.parent_comment_id
      parent_comment = Comment.find(@comment.parent_comment_id)
      parent_comment.children_number += 1
      parent_comment.save
    else
      @comment.children_number = 0
      @comment.save
    end
    respond_to do |format|
      format.json
      format.html { redirect_to "/videos/#{params[:video_id]}" }
    end
  end

  private

  def comment_params
    params.require(:comment).permit(
      :content,
      :parent_comment_id
    ).merge(
      user_id: current_user.id,
      video_id: params[:video_id]
    )
  end
end
