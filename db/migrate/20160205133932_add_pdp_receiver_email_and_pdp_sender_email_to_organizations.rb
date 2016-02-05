class AddPdpReceiverEmailAndPdpSenderEmailToOrganizations < ActiveRecord::Migration
  def change
    add_column :organizations, :pdp_receiver_email, :string
    add_column :organizations, :pdp_sender_email, :string
  end
end
