class DropImageable < ActiveRecord::Migration
  def change
    drop_table :imageables
  end
end
