class ApplicationController < ActionController::Base
  include ApplicationHelper
  protect_from_forgery with: :exception
  # use this devise helper to authenticate donor
  # before_action :authenticate_donor! has issues

  # saves the location before loading each page so we can return to the
  # right page. If we're on a devise page, we don't want to store that as the
  # place to return to (for example, we don't want to return to the sign in page
  # after signing in), which is what the :unless prevents
  before_action :store_current_location, unless: :devise_controller?

  # assembly of actions
  def index;     end

  def new;       end

  def create;    end

  def show;      end

  def edit;      end

  def update;    end

  def destroy;   end

  private

  # override the devise helper to store the current location so we can
  # redirect to it after loggin in or out. This override makes signing in
  # and signing up work automatically.
  def store_current_location
    store_location_for(:donor, request.url)
  end
end
