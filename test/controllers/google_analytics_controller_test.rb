require 'test_helper'

class GoogleAnalyticsControllerTest < ActionController::TestCase
  tests Garails::GoogleAnalyticsController

  context "GET to :utm" do
    setup do
      flexmock(@controller, :rand => 405451725)
      stub_analytics("0xd5d59357458cc280")
      get :utm, :format => :gif
    end
    should respond_with :success
    should assign_to(:visitor_id)
  end

  context "GET to :utm with guid" do
    setup do
      stub_analytics("0x80620d96c658ed0f")
      request.env["HTTP_X_DCMGUID"] = "blah"
      get :utm, :format => :gif
    end
    should respond_with :success
    should assign_to(:visitor_id)
  end

  def stub_analytics(vid)
    query = {
      :utmac => "MO-12345678-9", :utmcc => "__utma=999.999.999.999.999.1;", :utmcs => "UTF-8", 
      :utmhn => "example.org", :utmip => "0.0.0.0", :utmr => "-", :utmul => "en-us", 
      :utmvid => vid, :utmwv => "4.4sh" }
    stub_request(:get, "http://www.google-analytics.com/__utm.gif").
      with(:query => query, :headers => {'Accept'=>'*/*', 'User-Agent'=>'Rails%20Testing'}).
      to_return(:status => 200, :body => "", :headers => {})
  end

end
