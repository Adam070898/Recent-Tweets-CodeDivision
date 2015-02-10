class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.string :text
      t.belongs_to :twitter_user

      t.timestamps null: false
    end
  end
end
