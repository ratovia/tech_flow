json.array! @issues do |issue|
  json.id issue.id
  json.title issue.title
  json.content issue.content
  json.children do
    json.array! issue.children do |child|
      json.partial! 'api/v1/issues/issue' , node: child
    end
  end
end