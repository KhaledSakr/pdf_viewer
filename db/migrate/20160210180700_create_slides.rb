class CreateSlides < ActiveRecord::Migration
  def change
    create_table :slides do |t|

      t.timestamps null: false
    end
  end
end
