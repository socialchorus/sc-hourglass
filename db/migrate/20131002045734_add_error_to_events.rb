class AddErrorToEvents < ActiveRecord::Migration
  def change
    add_column :events, :error, :string
  end
end
