class OrganizationsController < InheritedResources::Base
  load_and_authorize_resource
  skip_load_and_authorize_resource :only => [:index, :show]
  before_filter only: [:create] { @organization.owner = current_user }
end
