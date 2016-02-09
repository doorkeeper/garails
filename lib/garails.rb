require 'rails'

module Garails

  # account identifier as issued by google analytics
  mattr_accessor :ga_account
  @@ga_account = nil

  def self.ga_setup?
    ! Garails.ga_account.blank?
  end
end

require 'garails/version'
require 'garails/engine'
