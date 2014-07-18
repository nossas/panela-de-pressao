class AddPdpSenderEmailToOrganization < ActiveRecord::Migration
  def change
    add_column :organizations, :pdp_sender_email, :string
  end
end
