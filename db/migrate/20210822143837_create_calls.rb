class CreateCalls < ActiveRecord::Migration[6.1]
  def change
    create_table :calls do |t|
      t.string :origin
      t.string :destiny
      t.integer :minuts
      t.decimal :value

      t.integer :plan_id, foreign_key: {to_table: :plans, name: 'rule_fk:calls.plan'}, null: false

      t.timestamps
    end
  end
end
