class VideosController < ApplicationController
before_action :authenticate_user!, only: [:new, :create, :edit, :update]

  def show
    @video = Video.find(params[:id])
    @video.count += 1
    @video.save

    @comment = Comment.new
    # その動画のidを持った全コメントを取得
    @comments = Comment.where(video_id: params[:id])
    # 返信コメントでないコメント(つまりparent_comment_idに値を持たないコメント)を取得
    @parent_comments = @comments.where(parent_comment_id: nil)

    @video_like = VideoLike.new
    # 訪れた視聴ページの動画のLikeをすべて取得する
    @video_likes = VideoLike.where(video_id: params[:id])
    if @video_likes.presence # Likeかdislikeが過去にある場合
      @video_like_number = @video_likes.where(like_state: "like").count
      @video_dislike_number = @video_likes.where(like_state: "dislike").count
      @current_user_like = @video_likes.find_by(user_id: current_user.id) if user_signed_in?
    else # Likeもdislikeも過去に無い場合
      @video_like_number = 0
      @video_dislike_number = 0
    end
    @video_id = params[:id]

    # サインインしていたら履歴を保存
    if user_signed_in?
      video_watch = Watch.find_or_initialize_by(user_id: current_user.id, video_id: @video.id)
       # ビデオの履歴ない場合は新規作成
      if video_watch.new_record?
        video_watch.save
      else
        # updateのみ更新して保存
        video_watch.touch
        video_watch.save
      end
    end

   @most_related_video  = @video.find_related_tags.order('count DESC')[0]
   @related_videos      = @video.find_related_tags.order('count DESC').offset(1).limit(9)


    # TODO: show画面のおすすめはタグに基づく方式にしたい
  end

  def index
    if user_signed_in?
      @own_videos              = current_user.videos.order('created_at DESC').limit(10)
      user_histrories          = current_user.watches.where(user_id: current_user.id).order('updated_at desc')
      recently_user_histrories = user_histrories.limit(10)
      @watched_videos           = recently_user_histrories.map{|histrory| histrory.video}.first(10)
      watched_ids              = user_histrories.select("video_id")
      unwatched_videos         = Video.where.not(id: watched_ids)
      @recommend_videos        = unwatched_videos.order('count DESC').limit(10)
    else
      @recommend_videos = Video.order('count DESC').limit(10)
    end
    # リファクタリングしたい
    @recently_videos  = Video.order('created_at DESC').limit(10)
  end

  def new
    @video = Video.new
  end

  def create
    if params[:video].nil?
      redirect_to ({ action: :new }), alert: '動画が選択されていません！！'
    else
    @video = Video.new(video_params)
    @video.count = 0
    @video.like_count = 0
    begin
      @video.save
      redirect_to edit_video_path(@video)
    rescue
      redirect_to ({ action: :new }), alert: "既に同じ動画が投稿されています"
    end
   end
  end

  # 入力ワード検索結果
  def search
    @q = Video.ransack(params[:q])
    @videos = @q.result.order(created_at: :desc)
  end

  # フィルタ機能(1時間前に投稿）
  def hour
    # 期間の設定
    to = DateTime.now.in_time_zone('Tokyo')
    from = to - 1.hour
    # searchの検索結果をさらに検索
    @filtered_videos = []
    params[:format].delete("/").split("").map(&:to_i).each do |i|
    @filtered_videos += Video.where(id: i, created_at: from...to)
    end
  end

  # フィルタ機能(今日に投稿）
  def today
    to = DateTime.now.in_time_zone('Tokyo')
    from = to - 1.day
    @filtered_videos = []
    params[:format].delete("/").split("").map(&:to_i).each do |i|
    @filtered_videos += Video.where(id: i, created_at: from...to)
    end
  end

  # フィルタ機能(1週間前に投稿）
  def week
    to = DateTime.now.in_time_zone('Tokyo')
    from = to - 1.week
    @filtered_videos = []
    params[:format].delete("/").split("").map(&:to_i).each do |i|
    @filtered_videos += Video.where(id: i, created_at: from...to)
    end
  end

  # フィルタ機能(１ヶ月前に投稿）
  def month
    to = DateTime.now.in_time_zone('Tokyo')
    from = to - 1.month
    @filtered_videos = []
    params[:format].delete("/").split("").map(&:to_i).each do |i|
    @filtered_videos += Video.where(id: i, created_at: from...to)
    end
  end
  
  # フィルタ機能(1年前に投稿）
  def year
    to = DateTime.now.in_time_zone('Tokyo')
    from = to - 1.year
    @filtered_videos = []
    params[:format].delete("/").split("").map(&:to_i).each do |i|
    @filtered_videos += Video.where(id: i, created_at: from...to)
    end
  end

  # フィルタ機能(投稿順）
  def up
    @filtered_videos= []
    params[:format].delete("/").split("").map(&:to_i).each do |i|
    @filtered_videos += Video.where(id: i)
    end
  end

  # フィルタ機能(視聴回数順）
  def count
    @sort_videos = []
    params[:format].delete("/").split("").map(&:to_i).each do |i|
    @sort_videos += Video.where(id: i)#.order(count: :desc)
    end
    @filtered_videos = @sort_videos.sort_by! {|video| video.count }.reverse
  end

  # フィルタ機能(評価順）
  def rank
    @sort_videos = []
    params[:format].delete("/").split("").map(&:to_i).each do |i|
    @sort_videos += Video.where(id: i)#.order(count: :desc)
    end
    @filtered_videos = @sort_videos.sort_by! {|video| video.like_count }.reverse
  end

  def edit
    @video = Video.find(params[:id])
    gon.video_tags = @video.tag_list
  end

  def update
    @video = Video.find(params[:id])
    if @video.user_id == current_user.id
       @video.update(video_params)
    end
  end

  private

  def video_params
    params.require(:video).permit(
      :title,
      :video,
      :description,
      :tag_list
      ).merge(user_id: current_user.id)
  end
end
# Ransackをインストールしたら、検索機能を付加したいアクション内で利用できます。今回はProductsControllerのindexアクションに作成

# qパラメータ(ここにはユーザから渡された検索パラメータが含まれます)を渡してsearchオブジェクトを作成します。見つかった商品を取得するために、このオブジェクトに対してresultを呼び出します。
