class CreateServiceConcerns < ActiveRecord::Migration
  def self.up
    create_table :service_concerns, :id => false do |t|
	
	t.integer :service_id
	t.integer :concern_id
	t.timestamps
    end
	execute("ALTER TABLE service_concerns ADD PRIMARY KEY(service_id, concern_id)")
  end

  def self.down
    drop_table :service_concerns
  end
end
