class AddPdpReceiverEmailToOrganization < ActiveRecord::Migration
  def change
    add_column :organizations, :pdp_receiver_email, :string
  end
end
