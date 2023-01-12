# frozen_string_literal: true

class AdminUsers::SessionsController < Devise::SessionsController
  layout 'admin'

  protected

  def after_sign_out_path_for(_resource_or_scope)
    admin_user_root_path
  end
end
