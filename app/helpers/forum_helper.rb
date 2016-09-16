# frozen_string_literal: true
module ForumHelper
  def forum
    @forum ||= Forum.find(params[:id])
  end

  def forums
    @forums ||= Forum.where(forum_id: nil).find_each
  end

  def post
    @post ||= Post.find(params[:id])
  end

  def posts
    @posts ||= Post.find_each
  end

  def topic
    @topic ||= Topic.find(params[:id])
  end

  def topics
    @topics ||= Topic.where(permitted_params).find_each
  end
end
