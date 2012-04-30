class PokesController < InheritedResources::Base
  nested_belongs_to :campaign
  before_filter :only => [:create] { params[:poke][:user_id] = current_user.id }

  def create
    create! do |success, failure|
      success.html { redirect_to @campaign }
    end
  end
end
