class AddUserIdToUploads < ActiveRecord::Migration
  def change
    add_column :uploads, :user_id, :int, :after => :id
  end
end
