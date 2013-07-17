Rails.application.routes.draw do
  get "utm" => "garails/google_analytics#utm", :as => "utm", :format => :gif
end
