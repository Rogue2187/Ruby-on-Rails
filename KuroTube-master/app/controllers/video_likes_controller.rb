class VideoLikesController < ApplicationController
  def create
    @video_like = VideoLike.new(video_like_params)
    @video_like.save

    # likeを押した時(+1)
    if  @video_like.like_state == 'like'
      @video = Video.find(params[:video_id])
      @video.like_count += 1
      @video.save
    end

    set_variables(params)
  end

  def update
    @video_like = VideoLike.find_by(video_id: params[:video_id], user_id: current_user.id)

    if  @video_like.like_state == 'like'
        @video_like.like_state = 'dislike'
    else
      @video_like.like_state = 'like'
    end
    @video_like.save

    # 現在dislikeでlikeを押した時(+1)
    if @video_like.like_state == 'dislike'
      @video = Video.find(params[:video_id])
      @video.like_count += 1
    # 現在likeでdislikeを押した時(-1)
    else
      @video = Video.find(params[:video_id])
      @video.like_count -= 1
    end
    @video.save

    set_variables(params)
  end

  def destroy
    current_user_like = VideoLike.find_by(video_id: params[:video_id], user_id: current_user.id)
    current_user_like.destroy
    # 現在likeでdislikeを押した時(-1)
    if current_user_like.like_state == 'like'

      @video = Video.find(params[:video_id])
      @video.like_count -= 1
      @video.save
    end
    set_variables(params)
  end

  private

  def set_variables(params)
    # 訪れた視聴ページの動画のLikeをすべて取得する
    @video_likes = VideoLike.where(video_id: params[:video_id])
    if @video_likes.presence # Likeかdislikeが過去にある場合
      @video_like_number = @video_likes.where(like_state: "like").count
      @video_dislike_number = @video_likes.where(like_state: "dislike").count
      @current_user_like = @video_likes.find_by(user_id: current_user.id) if user_signed_in?
    else # Likeもdislikeも過去に無い場合
      @video_like_number = 0
      @video_dislike_number = 0
    end
    @video_id = params[:video_id]
  end

  def video_like_params
    params.require(:video_like).permit(
      :like_state
    ).merge(video_id: params[:video_id], user_id: current_user.id)
  end
end
