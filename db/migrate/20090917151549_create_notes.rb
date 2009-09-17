class CreateNotes < ActiveRecord::Migration
  def self.up
    create_table :notes do |t|
      t.text :content
      #t.boolean :private # TODO: add support for private notes
      t.references :department
      t.references :noticeable, :polymorphic => true
      t.timestamps
    end
  end
  
  def self.down
    drop_table :notes
  end
end
