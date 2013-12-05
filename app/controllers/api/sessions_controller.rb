class Api::SessionsController < Devise::SessionsController
  respond_to :json

  def create
    self.resource = warden.authenticate!({scope: :user, :recall=>"api/sessions#failure"})
    set_flash_message(:notice, :signed_in) if is_flashing_format?
    sign_in(resource_name, resource)
    yield resource if block_given?
    respond_with resource, location: root_path
  end

  def failure
    render json: {success: false, errors: ["Login failed!"]}
  end
end
