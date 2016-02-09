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
    it { should include("ga('create', 'UA-FOO', 'auto')") }
    it { should include("ga('send', 'pageview')") }
  end

  context "has extra account setup" do
    before { Garails.ga_account = "UA-FOO" }
    subject { google_analytics_tracking_javascript("UA-OTHER") }
    it { should include("ga('create', 'UA-FOO', 'auto')") }
    it { should include("ga('send', 'pageview')") }
    it { should include("ga('create', 'UA-OTHER', 'auto', 'extraTracker')") }
    it { should include("ga('extraTracker.send', 'pageview')") }
  end
end
