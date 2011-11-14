
module Garails
  class Engine < ::Rails::Engine
    initializer 'garails.view.helper' do |app|
      ActionController::Base.helper Garails::MobileHelper, Garails::JavascriptHelper, Garails::EventHelper
    end
    initializer 'garails.controller.helper' do |app|
      ActionController::Base.send :include, Garails::EventHelper
    end
  end
end
