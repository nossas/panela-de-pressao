class AddEmailSignatureHtmlToOrganization < ActiveRecord::Migration
  def change
    add_column :organizations, :email_signature_html, :text
  end
end
