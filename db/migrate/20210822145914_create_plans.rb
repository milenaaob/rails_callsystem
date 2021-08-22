class CreatePlans < ActiveRecord::Migration[6.1]
  def change
    create_table :plans do |t|
      t.string :name, index: {unique: true, name: 'rule_unique:plans.name'}, null: false
      t.text :description

      t.string :data_refer, null: false

      t.timestamps
    end
  end
end
