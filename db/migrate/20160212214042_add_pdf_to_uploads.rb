class AddPDFsToUploads < ActiveRecord::Migration
  def self.up
    change_table :uploads do |t|
      t.attachment :document
    end
  end

  def self.down
    remove_attachment :uploads, :document
  end
end
