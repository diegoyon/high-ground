class AddFriUsernameToAthlete < ActiveRecord::Migration[7.0]
  def change
    add_column :athletes, :fri_username, :string
  end
end
