class AddSpecialableToSpecial < ActiveRecord::Migration[5.1]
  def change
    add_reference :specials, :specialable, polymorphic: true
  end
end
