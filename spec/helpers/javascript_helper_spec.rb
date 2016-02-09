require "spec_helper"

describe Garails::JavascriptHelper, type: :helper do
  after { Garails.ga_account = nil }

  context "no analytics account setup" do
    subject { google_analytics_tracking_javascript }
    it { should include("no google analytics account setup") }
  end

  context "has analytics account setup" do
    before { Garails.ga_account = "UA-FOO" }
    subject { google_analytics_tracking_javascript }
    it { should include("_gaq.push(['_setAccount', 'UA-FOO']);") }
    it { should include("_gaq.push(['_trackPageview']);") }
  end

  context "has extra account setup" do
    before { Garails.ga_account = "UA-FOO" }
    subject { google_analytics_tracking_javascript("UA-OTHER") }
    it { should include("_gaq.push(['_setAccount', 'UA-FOO']);") }
    it { should include("_gaq.push(['_trackPageview']);") }
    it { should include("_gaq.push(['b._setAccount', 'UA-OTHER'])") }
    it { should include("_gaq.push(['b._trackPageview'])") }
  end

  context "has analytics account setup with cookie domain, hostname, and extra account" do
    before do
      Garails.ga_account = "UA-FOO"
      Garails.ga_cookie_domain = ".example.com"
      Garails.ga_hostname = "www.example.com"
    end
    subject { google_analytics_tracking_javascript }
    it { should include("_gaq.push(['_setAccount', 'UA-FOO']);") }
    it { should include("_gaq.push(['_trackPageview']);") }
  end
end
