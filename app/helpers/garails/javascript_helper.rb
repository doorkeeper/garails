module Garails::JavascriptHelper
  def google_analytics_tracking_javascript
    if Garails.ga_setup?
      render :partial => "garails/google_analytics"
    else
      render :partial => "garails/no_google_analytics"
    end
  end
end
