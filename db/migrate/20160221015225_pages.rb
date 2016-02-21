class Pages < ActiveRecord::Migration
  def change
  	add_column :pages, :url, :string, :after => :id
  end
end
