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
  end

  def create
    @issue = Issue.new(issue_params)
    @issue.ancestry = nil if @issue.ancestry == ""
    @issue.build_article(article_params)
    @issue.save
    redirect_to root_path
  end

  def edit
    @issue = Issue.find(params[:id])
  end

  def update
    @issue = Issue.find(params[:id])
    @issue.article.update(article_params)
    redirect_to root_path
  end

  def destroy
    @issue = Issue.find(params[:id])
    @issue.children.each do |child|
      child.article.destroy
    end
    @issue.article.destroy
    redirect_to root_path
  end

  private

  def issue_params
    params.require(:issue).permit(:ancestry)
  end

  def article_params
    params.require(:issue).require(:article).permit(:title, :content)
  end
end
