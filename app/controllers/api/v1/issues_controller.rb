class Api::V1::IssuesController < ApplicationController
  protect_from_forgery

  def index
    @issues = Issue.where(ancestry: nil)
  end

  def create
    @issue = Issue.new(issue_params)
    @issue.save
    @issues = Issue.where(ancestry: nil)
  end

  private

  def issue_params
    params.permit(:title, :content)
  end
end
