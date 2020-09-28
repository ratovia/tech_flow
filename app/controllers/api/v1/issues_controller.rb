class Api::V1::IssuesController < ApplicationController
  def index
    @issues = Issue.where(ancestry: nil)
  end

  def search
    if params[:keyword] == nil || params[:keyword] == ""
      @issues = Issue.where(ancestry: nil)
    else
      @issues = Issue.where(['content LIKE ? OR title LIKE ?', "%#{params[:keyword]}%", "%#{params[:keyword]}%"])
    end
  end
end
