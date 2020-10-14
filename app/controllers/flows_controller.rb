class FlowsController < ApplicationController
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
    @issue.save
    redirect_to root_path
  end

  private

  def issue_params
    params.require(:issue).permit(:title, :content, :ancestry)
  end
end
