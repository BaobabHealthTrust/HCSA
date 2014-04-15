class CreateConcerns < ActiveRecord::Migration
  def self.up
    create_table :concerns, :primary_key => :concern_id do |t|
	
	t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :concerns
  end
end
