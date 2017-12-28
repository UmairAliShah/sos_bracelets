class AddContactableToContacts < ActiveRecord::Migration[5.1]
  def change
    add_reference :contacts, :contactable, polymorphic: true
  end
end
