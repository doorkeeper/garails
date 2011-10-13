require 'gabbara'
require 'digest'

class Garails::GoogleAnalyticsController < ActionController::Base
  unloadable
  before_filter :extract_visitor_id

  UTM_HEADERS = {
    "Content-Type" => "image/gif",
    "Cache-Control" => "private, no-cache, no-cache=Set-Cookie, proxy-revalidate",
    "Pragma" => "no-cache",
    "Expires" => "Wed, 17 Sep 1975 21:32:10 GMT" }
  UTM_GIF_DATA = [
    0x47, 0x49, 0x46, 0x38, 0x39, 0x61, 0x01, 0x00, 0x01, 0x00, 0x80, 0xff,
    0x00, 0xff, 0xff, 0xff, 0x00, 0x00, 0x00, 0x2c, 0x00, 0x00, 0x00, 0x00,
    0x01, 0x00, 0x01, 0x00, 0x00, 0x02, 0x02, 0x44, 0x01, 0x00, 0x3b ].map{|i| i.chr }.join
  UTM_COOKIE_NAME = "__utmmobile"

  def utm
    record_access if Garails.ga_setup?
    response.headers.merge(UTM_HEADERS)
    respond_to do |format|
      format.gif { send_data UTM_GIF_DATA, :type => :gif, :disposition => "inline" }
    end
  end

  private

  def record_access
    mobile_gabba.page_view('', :utmvid => @visitor_id)
  end

  def mobile_gabba
    Garails.mobile_gabba(request, :utmn => params[:utmn], :utmcc => "__utma=999.999.999.999.999.1;", :utmhid => "")
  end

  def extract_visitor_id
    @visitor_id = cookies[UTM_COOKIE_NAME] || construct_new_visitor_id
    cookie_data = {:value => @visitor_id, :expires => Time.now + 2.years, :path => '/'}
    cookie_data[:domain] = Garails.ga_cookie_domain unless Garails.ga_cookie_domain.blank?
    cookies[UTM_COOKIE_NAME] = cookie_data
  end

  def construct_new_visitor_id
    raw_visitor_id = request.env["HTTP_X_DCMGUID"].blank? ?
      ((request.env["HTTP_USER_AGENT"] || "") + rand(0x7fffffff).to_s) :
      (request.env["HTTP_X_DCMGUID"] + (Garails.ga_account || 'unknown'))
    "0x" + Digest::MD5.hexdigest(raw_visitor_id)[0, 16]
  end
end
