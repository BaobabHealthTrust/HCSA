class CreateSatlevels < ActiveRecord::Migration
  def self.up
    create_table :satlevels, :primary_key => :satlevel_id do |t|
	
	t.string :name
        t.timestamps
    end
  end

  def self.down
    drop_table :satlevels
  end
end
