module Garails::JavascriptHelper
  def google_analytics_tracking_javascript(extra_account=nil)
    if Garails.ga_setup?
      render :partial => "garails/google_analytics", :locals => { :extra_account => extra_account }
    else
      render :partial => "garails/no_google_analytics"
    end
  end
end
