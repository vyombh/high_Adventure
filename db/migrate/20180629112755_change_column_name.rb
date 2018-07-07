class ChangeColumnName < ActiveRecord::Migration
  def change
  	
  	rename_column :roomtypes, :adults, :baseadults
  	rename_column :roomtypes, :children, :basechildren
  	add_column :roomtypes, :maximumadults, :integer,default: 0
  	add_column :roomtypes, :maximumchildren, :integer,default: 0
  	add_column :roomtypes, :infants, :integer,default: 0
  	add_column :roomtypes, :maximumguests, :integer,default: 0
  	remove_column :roomtypes, :extrabed
  end
end
