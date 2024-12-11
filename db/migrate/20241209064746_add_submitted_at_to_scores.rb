class AddSubmittedAtToScores < ActiveRecord::Migration[8.0]
  def change
    add_column :scores, :submitted_at, :datetime
  end
end
