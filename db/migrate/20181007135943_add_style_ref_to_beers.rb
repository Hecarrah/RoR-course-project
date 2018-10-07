class AddStyleRefToBeers < ActiveRecord::Migration[5.1]
  def change
    add_reference :beers, :style, foreign_key: true
  end
end
