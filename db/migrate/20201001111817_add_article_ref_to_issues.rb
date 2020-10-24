class AddArticleRefToIssues < ActiveRecord::Migration[6.0]
  def change
    add_reference :issues, :article, null: false, foreign_key: true
  end
end
