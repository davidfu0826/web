class PageController < ApplicationController
  def index
    @posts = Post.all
  end
end
