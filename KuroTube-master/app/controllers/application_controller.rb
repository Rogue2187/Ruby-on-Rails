class ApplicationController < ActionController::Base

  before_action :search

  def search
    @q = Video.ransack(params[:q]) #ransackメソッド推奨<<<<<<< Updated upstream
    @videos = @q.result.order(created_at: :desc) #最新順
  end
end
