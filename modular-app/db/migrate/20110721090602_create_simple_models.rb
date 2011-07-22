class CreateSimpleModels < ActiveRecord::Migration
  def self.up
    create_table :simple_models do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :simple_models
  end
end
