class RenameHardcodedStylesToOldStyles < ActiveRecord::Migration[5.1]
  def change
    change_table :beers do |t|
      t.rename :style, :oldStyle
    end
  end
end
