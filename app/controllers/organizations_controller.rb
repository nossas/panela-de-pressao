#coding: utf-8
class OrganizationsController < InheritedResources::Base

  load_and_authorize_resource
  skip_load_and_authorize_resource :only => [:index, :show]
  before_filter only: [:create] { @organization.owner = current_user }
  
  def create
    create! do |success, failure|
      success.html { redirect_to organizations_path, :notice => "Sua organização foi criada! Que tal criar campanhas envolvendo usa organização?" }
      failure.html { render :new }
    end
  end

end
