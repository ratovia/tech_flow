class Api::V1::IssuesController < ApplicationController
  def index
    @issues = Issue.where(ancestry: nil).includes(:article)
  end
end
