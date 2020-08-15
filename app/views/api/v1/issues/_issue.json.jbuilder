json.id node.id
json.title node.title
json.content node.content
json.children do
  json.array! node.children do |child|
    json.partial! 'api/v1/issues/issue' , node: child
  end
end