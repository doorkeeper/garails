module Garails::MobileHelper

  def utm_tag
    image_tag utm_path, :alt => "", :size => "1x1"
  end

  def utm_path
    referer = request.env['HTTP_REFERER']
    url_for :controller => 'garails/google_analytics',
      :action => 'utm',
      :format => :gif,
      :utmn => rand(0x7fffffff).to_s,
      :utmr => referer.blank? ? "-" : referer,
      :utmp => request.env['REQUEST_URI'],
      :guid => "ON"
  end

end
