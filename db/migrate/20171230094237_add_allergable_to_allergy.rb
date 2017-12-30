class AddAllergableToAllergy < ActiveRecord::Migration[5.1]
  def change
    add_reference :allergies, :allergable, polymorphic: true
  end
end
