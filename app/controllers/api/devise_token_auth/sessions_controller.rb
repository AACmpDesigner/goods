class Api::DeviseTokenAuth::SessionsController <
  DeviseTokenAuth::SessionsController
  skip_before_action :verify_authenticity_token

  protected

  def render_create_success
    render json: { email: @resource.email, name: @resource.name }
  end
end
