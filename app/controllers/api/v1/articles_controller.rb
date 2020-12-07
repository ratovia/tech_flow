class Api::V1::ArticlesController < ApplicationController
  def index
    @article = Article.all
  end
end
