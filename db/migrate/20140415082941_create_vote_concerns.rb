class CreateVoteConcerns < ActiveRecord::Migration
  def self.up
    create_table :vote_concerns, :id => false do |t|
      t.integer  :vote_id
      t.integer  :concern_id
      t.timestamps
    end
	execute("ALTER TABLE vote_concerns ADD PRIMARY KEY(vote_id, concern_id)")
  end

      
  def self.down
    drop_table :vote_concerns
  end
end
