class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments, :primary_key => :comment_id do |t|
	
      t.integer	:service_id
      t.string	:comment

      t.timestamps
    end
  end

  def self.down
    drop_table :comments
  end
end
