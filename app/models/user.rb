# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  include DeviseTokenAuth::Concerns::User
  # class methods
  def self.seed
    return true if User.first

    user = User.create(
      email: 'test@example.com',
      password: '12345678',
      password_confirmation: '12345678',
      name: 'test'
    )
    user.valid?
  end
end
