json.array! @issues do |child|
  json.id child.parent.id
  json.title child.parent.article.title
  json.content child.parent.article.content
  json.children do
    json.array! child.parent.children do |node|
      json.partial! 'api/v1/issues/issue' , node: node
    end
  end
end
