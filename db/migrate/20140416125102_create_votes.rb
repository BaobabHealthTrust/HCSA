class CreateVotes < ActiveRecord::Migration
  def self.up
    create_table :votes, :primary_key => :vote_id do |t|
	
	t.string  :client_id
      	t.integer :satlevel_id
      	t.integer :service_id

      	t.timestamps
    end
  end

  def self.down
    drop_table :votes
  end
end
