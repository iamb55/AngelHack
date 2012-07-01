class RemoveConfirmationTokenAndConfirmedAtConfirmationSentAtUnconfirmedEmailFromMentors < ActiveRecord::Migration
  def up
    remove_column :mentors, :confirmation_token
    remove_column :mentors, :confirmed_at
    remove_column :mentors, :confirmation_sent_at
    remove_column :mentors, :unconfirmed_email
  end

  def down
    add_column :mentors, :unconfirmed_email, :string
    add_column :mentors, :confirmation_sent_at, :datetime
    add_column :mentors, :confirmed_at, :datetime
    add_column :mentors, :confirmation_token, :string
  end
end
