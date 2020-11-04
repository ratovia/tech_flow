json.id node.id
json.title node.article.title
json.content node.article.content
json.children do
  json.array! node.children do |child|
    json.partial! 'api/v1/issues/issue' , node: child
  end
end