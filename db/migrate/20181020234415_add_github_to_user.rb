class AddGithubToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :GitHub, :boolean
  end
end
