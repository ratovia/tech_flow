class Api::V1::IssuesController < ApplicationController
  def index
    @issues = Issue.where(ancestry: nil).includes(:article)
  end

  def search
    if params[:keyword] == nil || params[:keyword] == ""
      @issues = Issue.where(ancestry: nil)
    else
      @issues = Issue.where(['content LIKE ? OR title LIKE ?', "%#{params[:keyword]}%", "%#{params[:keyword]}%"])
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
