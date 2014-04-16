class CreateServices < ActiveRecord::Migration
  def self.up
    create_table :services, :primary_key => :service_id do |t|
	
	t.string :name

        t.timestamps
    end
  end

  def self.down
    drop_table :services
  end
end
