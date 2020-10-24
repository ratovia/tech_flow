class Api::V1::IssuesController < ApplicationController
  def index
    @issues = Issue.where(ancestry: nil).includes(:article)
  end

  def search
    if params[:keyword] == nil || params[:keyword] == ""
      @issues = Issue.where(ancestry: nil)
    else
      @issues = []
      Article.where(['content LIKE ?', "%#{params[:keyword]}%"]).each do |article|
        @issues << article.issues
      end
      Article.where(['title LIKE ?', "%#{params[:keyword]}%"]).each do |article|
        @issues << article.issues
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
