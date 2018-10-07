class AddStyleIDsToBeers < ActiveRecord::Migration[5.1]
  def change
    Beer.all.each do |b|
      s = Style.find_by(name: b.oldStyle)
      puts s.name
      b.style_id = s.id
      b.save
    end
  end
end
