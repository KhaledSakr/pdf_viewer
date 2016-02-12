class RemoveSlidesTable < ActiveRecord::Migration
  def change
  	drop_table :slides
  end
end
