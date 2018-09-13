class WatchesController < ApplicationController
  before_action :authenticate_user!

  # 視聴履歴の一覧
  def index
    @watches = current_user.watches.order(updated_at: :desc)
  end

  #履歴の削除
  def destroy
    watch = Watch.find(params[:id])
    watch.delete
    redirect_back(fallback_location: root_path)
  end

end
