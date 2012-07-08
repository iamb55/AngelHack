class RemoveConfirmationTokenAndConfirmedAtConfirmationSentAtUnconfirmedEmailFromMentees < ActiveRecord::Migration
  def up
    remove_column :mentees, :confirmation_token
    remove_column :mentees, :confirmed_at
    remove_column :mentees, :confirmation_sent_at
    remove_column :mentees, :unconfirmed_email
  end

  def down
    add_column :mentees, :unconfirmed_email, :string
    add_column :mentees, :confirmation_sent_at, :datetime
    add_column :mentees, :confirmed_at, :datetime
    add_column :mentees, :confirmation_token, :string
  end
end
