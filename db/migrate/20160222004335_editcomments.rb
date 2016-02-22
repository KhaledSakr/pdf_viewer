class Editcomments < ActiveRecord::Migration
  def change
  	remove_column :comments, :name
  	add_reference :comments, :user, index: true
  end
end
