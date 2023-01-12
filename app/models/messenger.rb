class Messenger
  include ActiveModel::Validations
  include ActiveModel::Model
  include ActiveModel::Conversion

  attr_accessor :name, :email, :message

  validates :name,    presence: true
  validates :email,   presence: true
  validates :message, presence: true
end
