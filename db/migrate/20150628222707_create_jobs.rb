class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.string :heading
      t.text :body
      t.string :timestamp
      t.string :external_url
      t.string :location

      t.timestamps
    end
  end
end
