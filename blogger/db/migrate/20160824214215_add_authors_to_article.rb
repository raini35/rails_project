class AddAuthorsToArticle < ActiveRecord::Migration[5.0]
  def change
  	add_column :articles, :author_id, :integer
  	add_column :authors, :article_id, :integer
  end
end
