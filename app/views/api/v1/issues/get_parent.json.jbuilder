json.array! @issues do |issue|
  json.id issue.parent.id
  json.title issue.parent.title
  json.content issue.parent.content
  json.children do
    json.array! issue.parent.children do |child|
      json.partial! 'api/v1/issues/issue' , node: child
    end
  end
end