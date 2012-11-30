class CreateScores < ActiveRecord::Migration
 def up
   create_table :scores do |s|
     s.string :rate
     s.string :comment
     s.references :event
   end
 end

 def down
   drop_table :scores
 end
end
