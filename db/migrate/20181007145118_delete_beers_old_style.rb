class DeleteBeersOldStyle < ActiveRecord::Migration[5.1]
  def change
    change_table :beers do |t|
      t.remove :oldStyle
    end
  end
end
