if ENV['BROWSERSTACK_USERNAME'].nil?
  raise 'please set BROWSERSTACK_USERNAME'
end
if ENV['BROWSERSTACK_PASSWORD'].nil?
  raise 'please set BROWSERSTACK_PASSWORD'
end

require 'capybara'
require 'capybara/rspec'
require 'selenium-webdriver'

caps = Selenium::WebDriver::Remote::Capabilities.firefox
caps['browser'] = 'Firefox'
caps['browser_version'] = '41.0'
caps['os'] = 'OS X'
caps['os_version'] = 'Yosemite'
caps['resolution'] = '1280x1024'
caps['project'] = 'My Great Project'
caps['build'] = "build_#{Time.now.to_i}"

Capybara.register_driver(:browserstack) do |app|
  Capybara::Selenium::Driver.new(
    app,
    browser: :remote,
    url: "http://#{ENV['BROWSERSTACK_USERNAME']}:#{ENV['BROWSERSTACK_PASSWORD']}@hub.browserstack.com/wd/hub",
    desired_capabilities: caps,
  )
end

Capybara.javascript_driver = :browserstack

RSpec.configure do |config|
  config.before(:each) do |example|
    Capybara.current_session.driver.options[:desired_capabilities]['name'] = example.full_description
  end

  config.after :each do
    Capybara.current_session.driver.quit
  end
end
