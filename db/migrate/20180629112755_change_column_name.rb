class ChangeColumnName < ActiveRecord::Migration
  def change
  	
  	rename_column :roomtypes, :adults, :baseadults
  	rename_column :roomtypes, :children, :basechildren
  	add_column :roomtypes, :maximumadults, :integer
  	add_column :roomtypes, :maximumchildren, :integer
  	add_column :roomtypes, :infants, :integer
  	add_column :roomtypes, :maximumguests, :integer
  	remove_column :roomtypes, :extrabed
  end
end
