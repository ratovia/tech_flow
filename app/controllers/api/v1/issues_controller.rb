class Api::V1::IssuesController < ApplicationController
  def index
    @issues = Issue.where(ancestry: nil).includes(:article)
  end

  def search
    if params[:keyword] == nil || params[:keyword] == ""
      @issues = Issue.where(ancestry: nil)
    else
      @issues = Article.where(['content LIKE ? OR title LIKE ?', "%#{params[:keyword]}%", "%#{params[:keyword]}%"]).map do |article|
        article.issues
      end
      @issues.flatten!
    end
  end

  def get_parent
    if params[:keyword] == nil || params[:keyword] == ""
      @issues = Issue.where(ancestry: nil)
    else
      @issues = Issue.where(id: params[:keyword])
    end
  end
end
