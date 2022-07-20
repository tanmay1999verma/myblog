class AddUserToArticles < ActiveRecord::Migration[7.0]
  def change
    add_reference :articles, :user, index: true
  end
end
1