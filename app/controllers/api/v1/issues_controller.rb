class Api::V1::IssuesController < ApplicationController
  protect_from_forgery

  def index
    @issues = Issue.where(ancestry: nil)
  end

  def create
    if params[:parent_id] == nil
      @issue = Issue.new(issue_params)
      @issues = Issue.where(ancestry: nil)
      @issue.save
    else
      parent_issue = Issue.find(params[:parent_id])
      @issue = parent_issue.children.new(issue_params)
      @issue.save
      @issues = parent_issue.children
    end
  end

  private

  def issue_params
    params.permit(:title, :content, :parent_id)
  end
end
