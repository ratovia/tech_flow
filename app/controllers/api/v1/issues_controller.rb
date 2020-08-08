class Api::V1::IssuesController < ApplicationController
  def index
    @issue = Issue.all
    render json: @issue
  end
end
