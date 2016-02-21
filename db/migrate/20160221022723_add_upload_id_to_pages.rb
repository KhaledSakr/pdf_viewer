class AddUploadIdToPages < ActiveRecord::Migration
  def change
  	change_table :pages do |t|
      t.references :upload, index: true, foreign_key: true
    end
  end
end
