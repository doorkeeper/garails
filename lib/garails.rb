require 'rails'

module Garails

  # account identifier as issued by google analytics
  mattr_accessor :ga_account
  @@ga_account = nil

  # cookie domain for the tracking cookie. Only set this if you need to
  # (e.g. for subdomain tracking). Corresponds to "_setDomainName".
  mattr_accessor :ga_cookie_domain
  @@ga_cookie_domain = nil

  # the host name (such as www.example.com). This is usually derived from the
  # incoming request. Set it here if you want to enable tracking outside your
  # controllers or views.
  mattr_accessor :ga_hostname
  @@ga_hostname = nil

  def self.ga_setup?
    ! Garails.ga_account.blank?
  end
end

require 'garails/version'
require 'garails/engine'
