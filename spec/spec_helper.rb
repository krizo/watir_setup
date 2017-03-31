require 'rubygems'
require 'bundler'
require 'watir'
require 'rspec'
require 'pry-rescue'
require 'require_all'
require_rel '../lib'

RSpec.configure do |config|
  include PageHelper

  config.before(:all) do
    init_browser
  end

  config.after(:suite) do
    CurrentBrowser.instance.browser.close rescue Errno::ECONNREFUSED
  end
end

def init_browser
  CurrentBrowser.instance.start_browser(ENV['BROWSER'])
  @browser = CurrentBrowser.instance.browser
end
