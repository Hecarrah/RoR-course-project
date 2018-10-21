class AddConfirmedToMemberships < ActiveRecord::Migration[5.1]
  def change
    add_column :memberships, :confirmed, :boolean
  end
end
