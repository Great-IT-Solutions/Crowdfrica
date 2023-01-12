class ApiController < ApplicationController
  skip_before_action :store_current_location, :verify_authenticity_token
  before_action :underscore_params!

  protected

  # does not do deep transforms! Rails 6.1 should help us solve this...
  # see https://stackoverflow.com/questions/17240106/what-is-the-best-way-to-convert-all-controller-params-from-camelcase-to-snake-ca
  def underscore_params!
    params.transform_keys!(&:underscore)
  end
end
