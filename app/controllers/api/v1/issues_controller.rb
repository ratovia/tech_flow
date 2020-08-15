class Api::V1::IssuesController < ApplicationController
  def index
    @issues = Issue.where(ancestry: nil)
  end
end
