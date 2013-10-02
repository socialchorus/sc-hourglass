class AddNonceToEvents < ActiveRecord::Migration
  def change
    add_column :events, :nonce, :integer
  end
end
