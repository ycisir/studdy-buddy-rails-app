class AddTopicRefToRooms < ActiveRecord::Migration[7.2]
  def change
    add_reference :rooms, :topic, null: false, foreign_key: true
  end
end
