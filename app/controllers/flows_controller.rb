class FlowsController < ApplicationController
  protect_from_forgery except: [:destroy]

  def index
  end

  def new
    if params[:parent_id]
      parent_issue = Issue.find(params[:parent_id])
      @issue = parent_issue.children.new
    else
      @issue = Issue.new
    end
    @issue.build_article
    @articles = Article.all
  end

  def create
    @issue = Issue.new(issue_params)
    @issue.ancestry = nil if @issue.ancestry == ""
    if article_params&.dig(:id) != ""
      article = Article.find(article_params[:id])
      @issue.article = article
    else
      @issue.build_article(article_params)
    end
    @issue.save
    redirect_to root_path
  end

  def edit
    @issue = Issue.find(params[:id])
    @articles = Article.all
  end

  def update
    @issue = Issue.find(params[:id])
    if article_params&.dig(:id)
      article = Article.find(article_params[:id])
      @issue.article = article
      @issue.save
    else
      @issue.article.update(article_params)
    end
    redirect_to root_path
  end

  def destroy
    @issue = Issue.find(params[:id])
    @issue.children.each do |child|
      child.destroy
    end
    @issue.destroy
    redirect_to root_path
  end

  private

  def issue_params
    params.require(:issue).permit(:ancestry)
  end

  def article_params
    params.require(:issue).require(:article).permit(:id, :title, :content)
  end
end
